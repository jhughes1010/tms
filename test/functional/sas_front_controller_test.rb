require 'test_helper'

class SasFrontControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get reports" do
    get :reports
    assert_response :success
  end

end
