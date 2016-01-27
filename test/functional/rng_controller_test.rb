require 'test_helper'

class RngControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
