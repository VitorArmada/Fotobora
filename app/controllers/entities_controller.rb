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
    @property = Property.new
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
