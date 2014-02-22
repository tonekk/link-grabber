require 'test_helper'

class LeadsControllerTest < ActionController::TestCase

  setup do
    sign_in_user
  end

  test "get #index" do
    get :index
    assert_response :success
  end
end
