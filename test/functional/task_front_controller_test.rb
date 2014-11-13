require 'test_helper'

class TaskFrontControllerTest < ActionController::TestCase
  test "should get top3Serial" do
    get :top3Serial
    assert_response :success
  end

  test "should get top3All" do
    get :top3All
    assert_response :success
  end

end
