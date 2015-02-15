class HuntsController < ApplicationController
  before_action :set_hunt, only: [:show, :edit, :update, :destroy]

  # GET /hunts
  # GET /hunts.json
  def index
    @hunts = Hunt.order(created_at: :desc).page params[:page]
  end

  # GET /hunts/1
  # GET /hunts/1.json
  def show
  end

  # GET /hunts/new
  def new
    @hunt = Hunt.new
  end

  # GET /hunts/1/edit
  def edit
  end

  # POST /hunts
  # POST /hunts.json
  def create
    @hunt = Hunt.new(hunt_params)

    respond_to do |format|
      if @hunt.save
        format.html { redirect_to @hunt, notice: 'Hunt was successfully created.' }
        format.json { render :show, status: :created, location: @hunt }
      else
        format.html { render :new }
        format.json { render json: @hunt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hunts/1
  # PATCH/PUT /hunts/1.json
  def update
    respond_to do |format|
      if @hunt.update(hunt_params)
        format.html { redirect_to @hunt, notice: 'Hunt was successfully updated.' }
        format.json { render :show, status: :ok, location: @hunt }
      else
        format.html { render :edit }
        format.json { render json: @hunt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hunts/1
  # DELETE /hunts/1.json
  def destroy
    @hunt.destroy
    respond_to do |format|
      format.html { redirect_to hunts_url, notice: 'Hunt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_hunt
    @hunt = Hunt.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def hunt_params
    params.require(:hunt).permit(:isbn, :condition)
  end
end
