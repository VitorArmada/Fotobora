class EntitystorycommentsController < ApplicationController
  before_action :set_entitystorycomment, only: [:show, :edit, :update, :destroy]

  # GET /entitystorycomments
  # GET /entitystorycomments.json
  def index
    @entitystorycomments = @entitystory.entitystorycomments
  end

  # GET /entitystorycomments/1
  # GET /entitystorycomments/1.json
  def show
  end

  # GET /entitystorycomments/new
  def new
    @entitystorycomment = Entitystorycomment.new
  end

  # GET /entitystorycomments/1/edit
  def edit
  end

  # POST /entitystorycomments
  # POST /entitystorycomments.json
  def create
    #@entitystorycomment = @entitystory.entitystorycomments.create(entitystorycomment_params)
    @entitystorycomment = Entitystorycomment.new(entitystorycomment_params)
    @entitystorycomment.user_id = current_user.id

    respond_to do |format|
      if @entitystorycomment.save
        format.html { redirect_to @entitystorycomment.entitystory, notice: 'Entitystorycomment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @entitystorycomment }
      else
        format.html { render action: 'new' }
        format.json { render json: @entitystorycomment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entitystorycomments/1
  # PATCH/PUT /entitystorycomments/1.json
  def update
    respond_to do |format|
      if @entitystorycomment.update(entitystorycomment_params)
        format.html { redirect_to @entitystorycomment, notice: 'Entitystorycomment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @entitystorycomment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entitystorycomments/1
  # DELETE /entitystorycomments/1.json
  def destroy
    entitystory = @entitystorycomment.entitystory
    @entitystorycomment.destroy
    respond_to do |format|
      format.html { redirect_to entitystory }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entitystorycomment
      @entitystorycomment = Entitystorycomment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entitystorycomment_params
      params.require(:entitystorycomment).permit(:text, :date, :entitystory_id, :user_id)
    end
end
