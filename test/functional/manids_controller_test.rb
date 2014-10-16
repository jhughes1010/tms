require 'test_helper'

class ManidsControllerTest < ActionController::TestCase
  setup do
    @manid = manids(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:manids)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create manid" do
    assert_difference('Manid.count') do
      post :create, :manid => @manid.attributes
    end

    assert_redirected_to manid_path(assigns(:manid))
  end

  test "should show manid" do
    get :show, :id => @manid.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @manid.to_param
    assert_response :success
  end

  test "should update manid" do
    put :update, :id => @manid.to_param, :manid => @manid.attributes
    assert_redirected_to manid_path(assigns(:manid))
  end

  test "should destroy manid" do
    assert_difference('Manid.count', -1) do
      delete :destroy, :id => @manid.to_param
    end

    assert_redirected_to manids_path
  end
end
