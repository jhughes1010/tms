require 'test_helper'

class CanMainsControllerTest < ActionController::TestCase
  setup do
    @can_main = can_mains(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:can_mains)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create can_main" do
    assert_difference('CanMain.count') do
      post :create, :can_main => @can_main.attributes
    end

    assert_redirected_to can_main_path(assigns(:can_main))
  end

  test "should show can_main" do
    get :show, :id => @can_main.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @can_main.to_param
    assert_response :success
  end

  test "should update can_main" do
    put :update, :id => @can_main.to_param, :can_main => @can_main.attributes
    assert_redirected_to can_main_path(assigns(:can_main))
  end

  test "should destroy can_main" do
    assert_difference('CanMain.count', -1) do
      delete :destroy, :id => @can_main.to_param
    end

    assert_redirected_to can_mains_path
  end
end
