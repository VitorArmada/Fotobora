class PhotostoriesController < ApplicationController
  before_action :set_photo, only: [:index, :new, :create]
  before_action :set_photostory, only: [:show, :edit, :update, :destroy]

  # GET /photostories
  # GET /photostories.json
  def index
    @photostories = @photo.photostories
  end

  # GET /photostories/1
  # GET /photostories/1.json
  def show
    @photostorycomment = Photostorycomment.new
  end

  # GET /photostories/new
  def new
    @photostory = @photo.photostories.build
  end

  # GET /photostories/1/edit
  def edit
  end

  # POST /photostories
  # POST /photostories.json
  def create
    @photostory = @photo.photostories.create(photostory_params)
    @photostory.user_id = current_user.id

    respond_to do |format|
      if @photostory.save
        format.html { redirect_to @photostory, notice: 'Story was successfully created.' }
        format.json { render action: 'show', status: :created, location: @photostory }
      else
        format.html { redirect_to new_photo_photostory_path(@photo), alert: 'Error(s) found when submitting story:' + @photostory.errors.full_messages.join(", ") }
        format.json { render json: @photostory.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photostories/1
  # PATCH/PUT /photostories/1.json
  def update
    respond_to do |format|
      if @photostory.update(photostory_params)
        format.html { redirect_to @photostory, notice: 'Story was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @photostory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photostories/1
  # DELETE /photostories/1.json
  def destroy
    photo = @photostory.photo
    @photostory.destroy
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
    def set_photostory
      @photostory = Photostory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photostory_params
      params.require(:photostory).permit(:title, :text, :date, :photo_id, :user_id)
    end
end
