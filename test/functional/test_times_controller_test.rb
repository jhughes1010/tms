require 'test_helper'

class TestTimesControllerTest < ActionController::TestCase
  setup do
    @test_time = test_times(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:test_times)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create test_time" do
    assert_difference('TestTime.count') do
      post :create, :test_time => @test_time.attributes
    end

    assert_redirected_to test_time_path(assigns(:test_time))
  end

  test "should show test_time" do
    get :show, :id => @test_time.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @test_time.to_param
    assert_response :success
  end

  test "should update test_time" do
    put :update, :id => @test_time.to_param, :test_time => @test_time.attributes
    assert_redirected_to test_time_path(assigns(:test_time))
  end

  test "should destroy test_time" do
    assert_difference('TestTime.count', -1) do
      delete :destroy, :id => @test_time.to_param
    end

    assert_redirected_to test_times_path
  end
end
