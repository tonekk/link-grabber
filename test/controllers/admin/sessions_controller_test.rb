require 'test_helper'

describe Admin::SessionsController do

  setup do
    @admin = Fabricate(:admin)
    @request.env["devise.mapping"] = Devise.mappings[:admin]
  end

  it "should render #new" do
    get :new
    @response.status.must_equal 200
  end

  it "should login" do
    post :create, {"admin"=>{"email"=>@admin.email,
                    "password"=>"secret-sauce"},
                    "remember_me"=>"on"
                  }

    @response.status.must_equal 302
    @response.location.must_equal admin_root_url
  end

  it "should login" do
    delete :destroy

    @response.status.must_equal 302
    @response.location.must_equal new_admin_session_url
  end
end
