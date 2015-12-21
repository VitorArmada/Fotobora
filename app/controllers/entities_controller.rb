class EntitiesController < ApplicationController
  before_action :set_photo, only: [:index, :new, :create]
  before_action :set_entity, only: [:show, :edit, :update, :destroy]

  # GET /entities
  # GET /entities.json
  def index
    @entities = @photo.entities
  end

  # GET /entities/1
  # GET /entities/1.json
  def show
    @people = @entity.photo.user.people 
    @propertytypes = Propertytype.all
    @vote = Vote.new
    @votetype = Votetype.new
    @property = Property.new

    
    @entitytypes = @entity.entitytypes 
    entitytype_sql = "(" + @entitytypes.map{|et| "'" + et.id.to_s + "'" }.join(',')+ ")" 
    vote_sums = ActiveRecord::Base.connection.execute("SELECT entitytype_id, entity_id, sum(value) as totalvotes 
      FROM votetypes 
      WHERE entity_id = #{@entity.id}
      AND entitytype_id IN #{entitytype_sql}
      GROUP BY entitytype_id, entity_id 
      ORDER BY totalvotes") 

    vote_sums_h = {}  

    vote_sums.each do |vs| 
    vote_sums_h[vs['entitytype_id']] = vs['totalvotes'] 
    end 

    @entitytypes = @entitytypes.to_a.sort_by!{|et| -(vote_sums_h[et.id] || 0) } 

 end

  # GET /entities/new
  def new
    @people = @photo.user.people 
    @entity = @photo.entities.build
  end

  # GET /entities/1/edit
  def edit
  end

  # POST /entities
  # POST /entities.json
  def create
    entity_params['properties_attributes'].each do |k,v|
      if v['value'] == ''
        entity_params['properties_attributes'].delete(k)
      end
    end

    @entity = @photo.entities.create(entity_params)
    @entity.user_id = current_user.id

    respond_to do |format|
      if @entity.save
        format.html { redirect_to @entity, notice: 'Entity was successfully identified.' }
        format.json { render action: 'show', status: :created, location: @entity }
      else
        format.html { render action: 'new' }
        format.json { render json: @entity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entities/1
  # PATCH/PUT /entities/1.json
  def update
    respond_to do |format|
      if @entity.update(entity_params)
        format.html { redirect_to @entity, notice: 'Entity was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @entity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entities/1
  # DELETE /entities/1.json
  def destroy
    photo = @entity.photo
    @entity.destroy
    respond_to do |format|
      format.html { redirect_to photo }
      format.json { head :no_content }
    end
  end


  def add_entity_type

    entity_params['properties_attributes'].each do |k,v|
      if v['value'] == ''
        entity_params['properties_attributes'].delete(k)
      end
    end

    @entity = Entity.find(entity_params[:current_id])
    selected_entitytype = Entitytype.find(entity_params[:entitytype_ids].first)
    @entity.entitytypes << selected_entitytype

    entity_params['properties_attributes'].each do |k,v|
     @entity.properties.create(v)
   end

   respond_to do |format|
    if @entity.save
      format.html { redirect_to @entity, notice: 'Entity was successfully attributed a new type.' }
      format.json { render action: 'show', status: :created, location: @entity }
    else
      format.html { render action: 'show' }
      format.json { render json: @entity.errors, status: :unprocessable_entity }
    end
  end

end


private
def set_photo
  @photo = Photo.find(params[:photo_id])
end

    # Use callbacks to share common setup or constraints between actions.
    def set_entity
      @entity = Entity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entity_params
      params.require(:entity).permit!#(
        # :x1, :x2, :y1, :y2, :user_id, :photo_id, :entitytype_id,
        #   property_attributes: [
        #     :_destroy,
        #     :id,
        #     :value,
        #     :certainty,
        #     :entity_id,
        #     :propertytype_id
        #   ]
        # )
end
end
