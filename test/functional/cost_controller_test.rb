require 'test_helper'

class CostControllerTest < ActionController::TestCase
  test "should get import" do
    get :import
    assert_response :success
  end

end
