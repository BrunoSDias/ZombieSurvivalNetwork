require 'test_helper'

class TradeControllerTest < ActionDispatch::IntegrationTest
  test "should get set_trade" do
    get trade_set_trade_url
    assert_response :success
  end

end
