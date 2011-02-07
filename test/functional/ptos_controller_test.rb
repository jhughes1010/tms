require 'test_helper'

class PtosControllerTest < ActionController::TestCase
  setup do
    @pto = ptos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ptos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pto" do
    assert_difference('Pto.count') do
      post :create, :pto => @pto.attributes
    end

    assert_redirected_to pto_path(assigns(:pto))
  end

  test "should show pto" do
    get :show, :id => @pto.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @pto.to_param
    assert_response :success
  end

  test "should update pto" do
    put :update, :id => @pto.to_param, :pto => @pto.attributes
    assert_redirected_to pto_path(assigns(:pto))
  end

  test "should destroy pto" do
    assert_difference('Pto.count', -1) do
      delete :destroy, :id => @pto.to_param
    end

    assert_redirected_to ptos_path
  end
end
