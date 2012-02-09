require 'test_helper'

class ImportResourceControllerTest < ActionController::TestCase
  test "should get import" do
    get :import
    assert_response :success
  end

end
