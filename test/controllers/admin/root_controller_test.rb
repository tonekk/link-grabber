require 'test_helper'

describe Admin::RootController do

  setup do
    sign_in_admin
  end

  it "should render #index" do
    get :index
    @response.status.must_equal 200
  end
end
