class TradeController < ApplicationController
  def set_trade
    survivor1 = Survivor.find(params[:id1])
    survivor2 = Survivor.find(params[:id2])

    
  end
end
