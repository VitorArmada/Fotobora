class VotetypesController < ApplicationController
  before_action :set_votetype, only: [:show, :edit, :update, :destroy]

  # GET /votetypes
  # GET /votetypes.json
  def index
    @votetypes = Votetype.all
  end

  # GET /votetypes/1
  # GET /votetypes/1.json
  def show
  end

  # GET /votetypes/new
  def new
    @votetype = Votetype.new
  end

  # GET /votetypes/1/edit
  def edit
  end

  # POST /votetypes
  # POST /votetypes.json
  def create
    @votetype = Votetype.new(votetype_params)

    has_withdrawn = false

    Votetype.where( "user_id = ? and entity_id = ? and entitytype_id = ?", @votetype.user_id, @votetype.entity_id, @votetype.entitytype_id  ).each do |v| 
        has_withdrawn = v.value == @votetype.value
        v.destroy
    end 

    if has_withdrawn 
      message = "Upvote for \"#{@votetype.entitytype.name}\" withdrawn." if @votetype.value > 0
      message = "Downvote for \"#{@votetype.entitytype.name}\" withdrawn." if @votetype.value < 0
      redirect_to @votetype.entity, notice: message
    else
      message = "Upvote for \"#{@votetype.entitytype.name}\" cast." if @votetype.value > 0
      message = "Downvote for \"#{@votetype.entitytype.name}\" cast." if @votetype.value < 0

      respond_to do |format|
        if @votetype.save
          format.html { redirect_to @votetype.entity, notice: message}
          format.json { render action: 'show', status: :created, location: @votetype }
        else
          format.json { render json: @votetype.errors, status: :unprocessable_entity }
        end
      end
    end  
  end

  # PATCH/PUT /votetypes/1
  # PATCH/PUT /votetypes/1.json
  def update
    respond_to do |format|
      if @votetype.update(votetype_params)
        format.html { redirect_to @votetype, notice: 'Votetype was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @votetype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /votetypes/1
  # DELETE /votetypes/1.json
  def destroy
    @votetype.destroy
    respond_to do |format|
      format.html { redirect_to votetypes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_votetype
      @votetype = Votetype.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def votetype_params
      params.require(:votetype).permit(:entity_id, :user_id, :entitytype_id, :value)
    end
end
