class EntitystoriesController < ApplicationController
  before_action :set_entity, only: [:index, :new, :create]
  before_action :set_entitystory, only: [:show, :edit, :update, :destroy]

  # GET /entitystories
  # GET /entitystories.json
  def index
    @entitystories = @entity.entitystories
  end

  # GET /entitystories/1
  # GET /entitystories/1.json
  def show
    @entitystorycomment = Entitystorycomment.new
  end

  # GET /entitystories/new
  def new
    @entitystory = @entity.entitystories.build
  end

  # GET /entitystories/1/edit
  def edit
  end

  # POST /entitystories
  # POST /entitystories.json
  def create
    @entitystory = @entity.entitystories.create(entitystory_params)
    @entitystory.user_id = current_user.id

    respond_to do |format|
      if @entitystory.save
        format.html { redirect_to @entitystory, notice: 'Story was successfully created.' }
        format.json { render action: 'show', status: :created, location: @entitystory }
      else
        format.html { render action: 'new' }
        format.json { render json: @entitystory.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entitystories/1
  # PATCH/PUT /entitystories/1.json
  def update
    respond_to do |format|
      if @entitystory.update(entitystory_params)
        format.html { redirect_to @entitystory, notice: 'Story was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @entitystory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entitystories/1
  # DELETE /entitystories/1.json
  def destroy
    entity = @entitystory.entity
    @entitystory.destroy
    respond_to do |format|
      format.html { redirect_to entity }
      format.json { head :no_content }
    end
  end

  private
    def set_entity
      @entity = Entity.find(params[:entity_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_entitystory
      @entitystory = Entitystory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entitystory_params
      params.require(:entitystory).permit(:title, :text, :date, :entity_id, :user_id)
    end
end
