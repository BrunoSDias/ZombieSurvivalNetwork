class TradeController < ApplicationController
  before_action :set_survivors, only: [:get_trade, :set_trade]

  def get_trade
    infected_survivors?
  end

  def set_trade
    @survivor1_itens = []
    @survivor2_itens = []

    params[:itens1_ids].tr('[]', '').split(',').map { |i| @survivor1_itens << i.to_i }
    params[:itens2_ids].tr('[]', '').split(',').map { |i| @survivor2_itens << i.to_i }

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

      if infected_survivors.empty?
        render json: {survivor01: @survivor1.inventory, survivor02: @survivor2.inventory}
      else
        render json: {message: "#{infected_survivors.join(',')} foram infectados, por isso não é possível realizar essa ação"}, status: 406
      end
    end

    def compare_points
      points_sur1 = 0
      points_sur2 = 0

      @survivor1_itens.each_with_index do |item, index|
        case index
        when 0
          points_sur1 += (item * 4)
          points_sur2 += (@survivor2_itens[index] * 4)
        when 1
          points_sur1 += (item * 3)
          points_sur2 += (@survivor2_itens[index] * 3)
        when 2
          points_sur1 += (item * 2)
          points_sur2 += (@survivor2_itens[index] * 2)
        when 3
          points_sur1 += (item * 1)
          points_sur2 += (@survivor2_itens[index] * 1)
        end
      end

      if points_sur1 == points_sur2
          @survivor1.inventory.water = @survivor2_itens[0]
          @survivor1.inventory.food = @survivor2_itens[1]
          @survivor1.inventory.medication = @survivor2_itens[2]
          @survivor1.inventory.ammunition = @survivor2_itens[3]

          @survivor2.inventory.water = @survivor1_itens[0]
          @survivor2.inventory.food = @survivor1_itens[1]
          @survivor2.inventory.medication = @survivor1_itens[2]
          @survivor2.inventory.ammunition = @survivor1_itens[3]

          @survivor1.inventory.save!
          @survivor2.inventory.save!

          render json: {survivor01: @survivor1.inventory, survivor02: @survivor2.inventory}, status: 200
      else
          render json: {message: 'O valor dos itens trocados devem ser os mesmos.'}, status: 406
      end
    end
end
