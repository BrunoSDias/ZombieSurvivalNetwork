class SurvivorsController < ApplicationController
  before_action :set_survivor, only: [:show, :update, :destroy, :report_counter]

  # GET /survivors
  def index
    @survivors = Survivor.all
    render json: @survivors, include: :inventory

  end

  # GET /survivors/1
  def show
    render json: @survivor, include: :inventory
  end

  # POST /survivors
  def create
    @survivor = Survivor.new(survivor_params)
    @survivor.build_inventory
    
    if @survivor.save
      render json: @survivor, include: :inventory, status: :created, location: @survivor
    else
      render json: @survivor.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /survivors/1
  def update
    if @survivor.update(update_survivor_params)
      render json: @survivor, include: :inventory
    else
      render json: @survivor.errors, status: :unprocessable_entity
    end
  end

  def report_counter
    @survivor.report_counter += 1
    if @survivor.report_counter >= 3
      @survivor.infected = true
    end
  end
  

  # DELETE /survivors/1
  def destroy
    @survivor.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_survivor
      @survivor = Survivor.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def survivor_params
      params.require(:survivor).permit(:name, :age, :gender, :latitude, :longitude, inventory_attributes: [ :water, :food, :medication, :ammunition ])
    end

    def update_survivor_params
      params.require(:survivor).permit(:latitude, :longitude)
    end
end
