class RequestsController < ApplicationController
    before_action :set_photo, only: [:index, :new, :create]
  before_action :set_requests, only: [:show, :edit, :update, :destroy]

  # GET /requests
  # GET /requests.json
  def index
    @requests = @photo.requests
  end

  # GET /requests/1
  # GET /requests/1.json
  def show

  end

  # GET /requests/new
  def new
    @request = @photo.requests.build
  end

  # GET /requests/1/edit
  def edit
  end

  # POST /requests
  # POST /requests.json
  def create
    @requests = @photo.requests.create(requests_params)
    @requests.user_id = current_user.id

    respond_to do |format|
      if @requests.save
        format.html { redirect_to @requests, notice: 'Story was successfully created.' }
        format.json { render action: 'show', status: :created, location: @requests }
      else
        format.html { redirect_to new_photo_requests_path(@photo), alert: 'Error(s) found when submitting requests:' + @requests.errors.full_messages.join(", ") }
        format.json { render json: @requests.errors, status: :unprocessable_entity }
      end
    end
  end
  # PATCH/PUT /requests/1
  # PATCH/PUT /requests/1.json
  def update
    respond_to do |format|
      if @request.update(request_params)
        format.html { redirect_to @request, notice: 'Request was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/1
  # DELETE /requests/1.json
  def destroy
    @request.destroy
    respond_to do |format|
      format.html { redirect_to requests_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request
      @request = Request.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def request_params
      params.require(:request).permit(:title, :text, :date, :photo_id, :user_id)
    end
end
