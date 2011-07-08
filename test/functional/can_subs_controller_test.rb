require 'test_helper'

class CanSubsControllerTest < ActionController::TestCase
  setup do
    @can_sub = can_subs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:can_subs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create can_sub" do
    assert_difference('CanSub.count') do
      post :create, :can_sub => @can_sub.attributes
    end

    assert_redirected_to can_sub_path(assigns(:can_sub))
  end

  test "should show can_sub" do
    get :show, :id => @can_sub.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @can_sub.to_param
    assert_response :success
  end

  test "should update can_sub" do
    put :update, :id => @can_sub.to_param, :can_sub => @can_sub.attributes
    assert_redirected_to can_sub_path(assigns(:can_sub))
  end

  test "should destroy can_sub" do
    assert_difference('CanSub.count', -1) do
      delete :destroy, :id => @can_sub.to_param
    end

    assert_redirected_to can_subs_path
  end
end
