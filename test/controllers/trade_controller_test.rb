require 'test_helper'

class TradeControllerTest < ActionDispatch::IntegrationTest
  setup do
    @survivor1 = survivors(:one)
    @survivor2 = survivors(:two)
  end

  test "should get trade info" do
    get trade_path(survivor_1: @survivor1.id, survivor_2: @survivor2.id)
    assert_response 200
  end
  
  test "should set trade" do
    post trade_path, params: {survivor_1: @survivor1.id, survivor_2: @survivor2.id, itens1_values: '[1,0,0,0]', itens2_values:'[0,1,0,1]' }
    assert_response 200
  end
  
  test "should not set trade with diferent values of itens" do
    post trade_path, params: {survivor_1: @survivor1.id, survivor_2: @survivor2.id, itens1_values: '[1,1,0,0]', itens2_values:'[0,1,0,1]' }
    assert_response 406
  end
  
  test "should not set trade with wrong size of array" do
    post trade_path, params: {survivor_1: @survivor1.id, survivor_2: @survivor2.id, itens1_values: "[1,0,0,0,'']", itens2_values:'[0,1,0,1]' }
    assert_response 406
  end
end
