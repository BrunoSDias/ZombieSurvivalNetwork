require 'test_helper'

class SurvivorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @survivor = survivors(:one)
  end

  test "should get index" do
    get survivors_url, as: :json
    assert_response :success
  end

  test "should create survivor" do
    assert_difference('Survivor.count') do
      post survivors_url, params: { survivor: { age: @survivor.age, gender: @survivor.gender, latitude: @survivor.latitude, longitude: @survivor.longitude, name: @survivor.name, inventory_attributes: {water: 1, food: 2, medication: 3, ammunition: 4} } }, as: :json
    end

    assert_response 201
  end

  test "should not create survivor" do
    assert_no_difference('Survivor.count') do
      post survivors_url, params: { survivor: { age: '', gender: @survivor.gender, latitude: @survivor.latitude, longitude: @survivor.longitude, name: @survivor.name, inventory_attributes: {water: 1, food: 2, medication: 3, ammunition: 4} } }, as: :json
    end

    assert_response 422
  end

  test "should show survivor" do
    get survivor_url(@survivor), as: :json
    assert_response :success
  end

  test "should update survivor location" do
    patch survivor_url(@survivor), params: { survivor: {latitude: @survivor.latitude, longitude: @survivor.longitude} }, as: :json
    assert_response 200
  end

  test "should not update survivor location" do
    patch survivor_url(@survivor), params: { survivor: {latitude: '', longitude: @survivor.longitude} }, as: :json
    assert_response 422
  end

  test "should increase survivor report_counter" do
    get report_path(id: @survivor.id), as: :json
    assert_not_equal( @survivor.report_counter, Survivor.find(@survivor.id).report_counter)
    assert_response 200
  end

  test "should get survivors info" do
    get survivors_info_path, as: :json
    assert_response 200
  end
end
