class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy, :print, :import, :import_post]

  # GET /photos
  # GET /photos.json
  def index
    @photos = Photo.all
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
  end

  # GET /photos/new
  def new
    @photo = Photo.new
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = Photo.new(photo_params)
    @photo.user_id = current_user.id

    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
        format.json { render action: 'show', status: :created, location: @photo }
      else
        format.html { render action: 'new' }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to  }
      format.json { head :no_content }
    end
  end

  def print
    render :layout => "print"
  end

  def import

    # Generate Schema

      # Check if schema needs updating and update it if needed

      schema_mtime = File.mtime('public/Schema.xsd')
      entity_mtime = Entitytype.all.max_by{ |x| x.updated_at }.updated_at
      property_mtime = Propertytype.all.max_by{ |x| x.updated_at }.updated_at

      if schema_mtime < entity_mtime || schema_mtime < property_mtime
      # There is one type of entity or property more recent than the schema
      # i.e. the schema is out-of-date, so it will be updated 
        
        schema_path = 'public/Schema.xsd'

        schema_read = File.open(schema_path)

        schema = Nokogiri::XML(schema_read)

        entity_types = schema.xpath('//xs:simpleType[@name = "tipoEnt"]/xs:restriction').first
        property_types = schema.xpath('//xs:simpleType[@name = "tipoProp"]/xs:restriction').first

        entity_types.children.each {|x| x.remove}
        property_types.children.each {|x| x.remove}

        Entitytype.all.each do |et|
          nET = Nokogiri::XML::Node.new "xs:enumeration", schema
          nET['value'] = et.name
          entity_types.add_child( nET )
        end

        Propertytype.all.each do |pt|
          nPT = Nokogiri::XML::Node.new "xs:enumeration", schema
          nPT['value'] = pt.name
          property_types.add_child( nPT )
        end

        #schema_write =
        File.open(schema_path, 'w') { |f| f.puts schema.to_xml }
        
        schema_read.close()

      end

    # Get last updated time for the schema

      schema_file_mtime = File.mtime('public/Schema.xsd')
      flash[:schema_updated_at] = schema_file_mtime.to_s

  end
  
  def import_post

    file_io = params[:file]

    # Check if a file was uploaded

      if file_io.nil?
        flash[:errors] =
          [ "No file submitted. Submit a file." ]
        redirect_to import_photo_url(@photo)
        return
      end

    # Check if it's a XML file

      if file_io.content_type != 'text/xml'
        flash[:errors] =
          [ "The submitted file is not a valid XML file." ]
        redirect_to import_photo_url(@photo)
        return
      end

    # Parse as XML and detect errors

      begin
        xml = Nokogiri::XML(file_io) { |config|
          config.strict
          config.noblanks
        }
      rescue Nokogiri::XML::SyntaxError => e
        flash[:errors] =
          [ "#{e}" ]
        redirect_to import_photo_url(@photo)
        return
      end

    # Generate Schema

      # It already was generated when first viewing the 'Import' view

      schema_file_mtime = File.mtime('public/Schema.xsd')
      flash[:schema_updated_at] = schema_file_mtime.to_s

    # Validate against schema

      file_schema = File.new("public/Schema.xsd","r")
      xsd = Nokogiri::XML::Schema(file_schema)
      errors = xsd.validate(xml)

      if ! errors.empty?
        flash[:errors] =
          errors.map{ |err| err.message }
        redirect_to import_photo_url(@photo)
        return
      end

    # Validate Entity Types and Property Types combinations

      # Retrieve Entity and Property Types and assemble hashes

        entity_types = Hash.new

        Entitytype.all.each do |et|
          entity_types[ et.name ] = {
            'et' => et,
            'pts' => Hash[et.propertytypes.all.map { |pt| [pt.name, pt]  }]
          }
        end

      # Transverse XML document and check type coherence

        type_mismatches = [ ]

        nodesProperty = xml.xpath("//Propriedade")

        nodesProperty.each do |nP|
          node_entity_type = nP.parent['tipo']

          # Check if the property type is valid for the indicated entity type

          valid_propertytypes = entity_types[ node_entity_type ]['pts']

          if valid_propertytypes.has_key?( nP['tipo'] ) == false
            type_mismatches << { 
              :line       => nP.line,
              :et         => node_entity_type,
              :wrong_pt   => nP['tipo'],
              :valid_pts  => valid_propertytypes.keys
            }
          end
        end

        if ! type_mismatches.empty?
          flash[:errors] =
            type_mismatches.map{
              |tm| "Invalid property type on line #{tm[:line]}: #{tm[:wrong_pt]}  isn't a valid property for #{tm[:et]} entities, the valid properties are [#{tm[:valid_pts].join(', ')}]"
            }
          redirect_to import_photo_url(@photo)
          return
        end

    # Import annotations

      # Transverse XML document and build model instances

        nodesEntity = xml.xpath("//Entidade")

        nodesEntity.each do |nE|
          entity = @photo.entities.build
          entity.x1 = nE['x1']
          entity.x2 = nE['x2']
          entity.y1 = nE['y1']
          entity.y2 = nE['y2']
          entity.user_id = current_user.id
          entity.entitytype_id =
            entity_types[ nE['tipo'] ].et.id;

          entity.save # sets id, created_at and updated_at attributes

          nodesProperty = nE.xpath("./Propriedade")

          nodesProperty.each do |nP|
            property = entity.properties.build
            property.value = nP.content.strip
            property.certainty = nP['certeza']
            property.propertytype_id =
              entity_types[ nE['tipo'] ].pts[ nP['tipo'] ].id;

            property.save
          end
        end

      # Redirect to Photo page

        redirect_to @photo, notice: 'Photo annotations successfully imported.'

  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:address, :date, :user_id, :picture)
    end
end
