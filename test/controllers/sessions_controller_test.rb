require 'test_helper'

describe SessionsController do

  setup do
    @user = Fabricate(:user)
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  it "should render #new" do
    get :new
    @response.status.must_equal 200
  end

  it "should login" do
    post :create, {"user"=>{"email"=>@user.email,
                    "password"=>"secret-sauce"},
                    "remember_me"=>"on"
                  }

    @response.status.must_equal 302
    @response.location.must_equal leads_url
  end

  it "should login" do
    delete :destroy

    @response.status.must_equal 302
    @response.location.must_equal new_user_session_url
  end
end
