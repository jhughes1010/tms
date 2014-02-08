require 'test_helper'

class SasControllerTest < ActionController::TestCase
  setup do
    @sa = sas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sa" do
    assert_difference('Sa.count') do
      post :create, :sa => @sa.attributes
    end

    assert_redirected_to sa_path(assigns(:sa))
  end

  test "should show sa" do
    get :show, :id => @sa.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @sa.to_param
    assert_response :success
  end

  test "should update sa" do
    put :update, :id => @sa.to_param, :sa => @sa.attributes
    assert_redirected_to sa_path(assigns(:sa))
  end

  test "should destroy sa" do
    assert_difference('Sa.count', -1) do
      delete :destroy, :id => @sa.to_param
    end

    assert_redirected_to sas_path
  end
end
