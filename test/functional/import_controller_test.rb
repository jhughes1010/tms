require 'test_helper'

class ImportControllerTest < ActionController::TestCase
  test "should get npi" do
    get :npi
    assert_response :success
  end

end
