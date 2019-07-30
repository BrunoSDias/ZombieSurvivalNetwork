class SurvivorsController < ApplicationController
  before_action :set_survivor, only: [:show, :update, :destroy, :report_counter]

  def index
    @survivors = Survivor.all
    render json: @survivors, include: :inventory

  end

  def show
    render json: @survivor, include: :inventory
  end

  def create
    @survivor = Survivor.new(survivor_params)
    @survivor.build_inventory
    
    if @survivor.save
      render json: @survivor, include: :inventory, status: :created, location: @survivor
    else
      render json: @survivor.errors, status: :unprocessable_entity
    end
  end

  def update
    if @survivor.update(update_survivor_params)
      render json: @survivor, include: :inventory, status: :ok
    else
      render json: @survivor.errors, status: :unprocessable_entity
    end
  end

  def report_counter
    @survivor.report_counter += 1
    if @survivor.report_counter >= 3
      @survivor.infected = true
    end

    if @survivor.save
      render json: @survivor, include: :inventory, status: :ok, location: @survivor
    else
      render json: @survivor.errors, status: :unprocessable_entity
    end
  end
  

  def destroy
    @survivor.destroy
  end

  def survivors_info
    infected = 0
    total_water = 0
    total_food = 0
    total_medication = 0
    total_ammunition = 0
    avg_water = 0
    avg_food = 0
    avg_medication = 0
    avg_ammunition = 0
    survivors = Survivor.all

    survivors.each do |s|
      s.infected ? infected += 1 : ""
      unless s.infected
        total_water += s.inventory.water
        total_food += s.inventory.food
        total_medication += s.inventory.medication
        total_ammunition += s.inventory.ammunition
      end
    end

    avg_water = total_water/survivors.count
    avg_food = total_food/survivors.count
    avg_medication = total_medication/survivors.count
    avg_ammunition = total_ammunition/survivors.count



    percentage_infected = (infected*100)/survivors.count
    render json: {percentage_infected: percentage_infected,
                  percentage_non_infected: 100 - percentage_infected,
                    average_amount_of_resource: {
                      water: avg_water,
                      food: avg_food,
                      medication: avg_medication,
                      ammunition: avg_ammunition
                    }
                  }
  end

  private
    def set_survivor
      @survivor = Survivor.find(params[:id])
    end

    def survivor_params
      params.require(:survivor).permit(:name, :age, :gender, :latitude, :longitude, inventory_attributes: [ :water, :food, :medication, :ammunition ])
    end

    def update_survivor_params
      params.require(:survivor).permit(:latitude, :longitude)
    end
end
