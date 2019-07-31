class TradeController < ApplicationController
  before_action :set_survivors, only: [:get_trade, :set_trade]
  before_action :check_qnt_itens, only: [:compare_points]
  before_action :infected_survivors?, only: [:get_trade, :set_trade]

  def get_trade
    render json: {survivor01: @survivor1.inventory, survivor02: @survivor2.inventory}, status: 200
  end

  def set_trade
    @survivor1_trade_itens = []
    @survivor2_trade_itens = []

    params[:itens1_values].tr('[]', '').split(',').map { |i| @survivor1_trade_itens << i.to_i }
    params[:itens2_values].tr('[]', '').split(',').map { |i| @survivor2_trade_itens << i.to_i }

    if @survivor1_trade_itens.count > 4 || @survivor2_trade_itens.count > 4
      render json: {message: 'Wrong number of sended parameters (a array of 4 parameters must be sended)'}, status: 406
      return
    end

    compare_points
  end

  private

    def set_survivors
      @survivor1 = Survivor.find(params[:survivor_1])
      @survivor2 = Survivor.find(params[:survivor_2])
    end

    def infected_survivors?
      infected_survivors = []
      if @survivor1.infected
        infected_survivors << @survivor1.name
      end
      if @survivor2.infected
        infected_survivors << @survivor2.name
      end

      unless infected_survivors.empty?
        render json: {message: "#{infected_survivors.join(',')} were infected, so it is not possible to perform this action"}, status: 401
        return
      end
    end

    def compare_points
      points_sur1 = 0
      points_sur2 = 0

      @survivor1_trade_itens.each_with_index do |item, index|
        case index
        when 0
          points_sur1 += (item * 4)
          points_sur2 += (@survivor2_trade_itens[index] * 4)
        when 1
          points_sur1 += (item * 3)
          points_sur2 += (@survivor2_trade_itens[index] * 3)
        when 2
          points_sur1 += (item * 2)
          points_sur2 += (@survivor2_trade_itens[index] * 2)
        when 3
          points_sur1 += (item * 1)
          points_sur2 += (@survivor2_trade_itens[index] * 1)
        end
      end

      if points_sur1 == points_sur2
          @survivor1.inventory.water -= @survivor1_trade_itens[0]
          @survivor1.inventory.water += @survivor2_trade_itens[0]
          @survivor1.inventory.food -= @survivor1_trade_itens[1]
          @survivor1.inventory.food += @survivor2_trade_itens[1]
          @survivor1.inventory.medication -= @survivor1_trade_itens[2]
          @survivor1.inventory.medication += @survivor2_trade_itens[2]
          @survivor1.inventory.ammunition -= @survivor1_trade_itens[3]
          @survivor1.inventory.ammunition += @survivor2_trade_itens[3]

          @survivor2.inventory.water -= @survivor2_trade_itens[0]
          @survivor2.inventory.water += @survivor1_trade_itens[0]
          @survivor2.inventory.food -= @survivor2_trade_itens[1]
          @survivor2.inventory.food += @survivor1_trade_itens[1]
          @survivor2.inventory.medication -= @survivor2_trade_itens[2]
          @survivor2.inventory.medication += @survivor1_trade_itens[2]
          @survivor2.inventory.ammunition -= @survivor2_trade_itens[3]
          @survivor2.inventory.ammunition += @survivor1_trade_itens[3]

          @survivor1.inventory.save!
          @survivor2.inventory.save!

          render json: {survivor01: @survivor1.inventory, survivor02: @survivor2.inventory}, status: 200
      else
          render json: {message: 'The value of the exchanged items must be the same.'}, status: 406
      end
    end
  
    def check_qnt_itens
      survivor1_itens = {water: @survivor1.inventory.water,
                         food: @survivor1.inventory.food,
                         medication: @survivor1.inventory.medication,
                         ammunition: @survivor1.inventory.ammunition}

      survivor2_itens = {water: @survivor2.inventory.water,
                         food: @survivor2.inventory.food,
                         medication: @survivor2.inventory.medication,
                         ammunition: @survivor2.inventory.ammunition}
      
      survivor1_itens.each_with_index do |(key, value), index|
        if value < @survivor1_trade_itens[index]
          render json: {message: "The #{@survivor1.name} doesn't have this amount of #{key} to the exchange"}, status: 406
          return
        end
        
        if survivor2_itens[key] < @survivor2_trade_itens[index]
          render json: {message: "O #{@survivor2.name} doesn't have this amount of #{key} to the exchange"}, status: 406
          return
        end
      end
    end
end
