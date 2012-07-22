require 'test_helper'

class TestProgsControllerTest < ActionController::TestCase
  setup do
    @test_prog = test_progs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:test_progs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create test_prog" do
    assert_difference('TestProg.count') do
      post :create, :test_prog => @test_prog.attributes
    end

    assert_redirected_to test_prog_path(assigns(:test_prog))
  end

  test "should show test_prog" do
    get :show, :id => @test_prog.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @test_prog.to_param
    assert_response :success
  end

  test "should update test_prog" do
    put :update, :id => @test_prog.to_param, :test_prog => @test_prog.attributes
    assert_redirected_to test_prog_path(assigns(:test_prog))
  end

  test "should destroy test_prog" do
    assert_difference('TestProg.count', -1) do
      delete :destroy, :id => @test_prog.to_param
    end

    assert_redirected_to test_progs_path
  end
end
