class PhotostorycommentsController < ApplicationController
  before_action :set_photostorycomment, only: [:show, :edit, :update, :destroy]

  # GET /photostorycomments
  # GET /photostorycomments.json
  def index
    @photostorycomments = @photostory.photostorycomments
  end

  # GET /photostorycomments/1
  # GET /photostorycomments/1.json
  def show
  end

  # GET /photostorycomments/new
  def new
    @photostorycomment = Photostorycomment.new
  end

  # GET /photostorycomments/1/edit
  def edit
  end

  # POST /photostorycomments
  # POST /photostorycomments.json
  def create
    #@photostorycomment = @photostory.photostorycomments.create(photostorycomment_params)
    @photostorycomment = Photostorycomment.new(photostorycomment_params)
    @photostorycomment.user_id = current_user.id
    
    respond_to do |format|
      if @photostorycomment.save
        format.html { redirect_to @photostorycomment.photostory, notice: 'Photostorycomment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @photostorycomment }
      else
        format.html { redirect_to @photostorycomment.photostory, alert: 'Error found when submitting comment:' + @photostorycomment.errors.full_messages.join(", ") }
        format.json { render json: @photostorycomment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photostorycomments/1
  # PATCH/PUT /photostorycomments/1.json
  def update
    respond_to do |format|
      if @photostorycomment.update(photostorycomment_params)
        format.html { redirect_to @photostorycomment, notice: 'Photostorycomment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @photostorycomment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photostorycomments/1
  # DELETE /photostorycomments/1.json
  def destroy
    photostory = @photostorycomment.photostory
    @photostorycomment.destroy
    respond_to do |format|
      format.html { redirect_to photostory }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photostorycomment
      @photostorycomment = Photostorycomment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photostorycomment_params
      params.require(:photostorycomment).permit(:text, :date, :photostory_id, :user_id)
    end
end
