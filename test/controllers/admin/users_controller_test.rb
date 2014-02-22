require 'test_helper'

describe Admin::UsersController do

  setup do
    sign_in_admin
    @lead_class = Fabricate(:lead_class)
    @user = Fabricate(:user)
  end

  it "should render #index" do
    get :index
    @response.status.must_equal 200
  end

  it "should render #new" do
    get :new
    @response.status.must_equal 200
  end

  it "shoud create record" do
    assert_difference ->{User.all.count}, +1 do
      post :create, {"user"=>{"full_name"=>"Hans zu dem Peter",
                              "email"=>"hans@zudempeter.de",
                              "lead_class_ids"=>
                                [@lead_class.id]
                             }
                    }
    end

    @response.status.must_equal 302
    @response.location.must_equal admin_users_url
  end

  it "should render #edit" do
    get :edit, id: @user.id
    @response.status.must_equal 200
  end

  it "shoud update record" do
    assert_no_difference ->{User.all.count} do
      put :update, {"id"=>@user.id,
                    "user"=>{
                              "full_name"=>"Hans zu dem Peter",
                              "email"=>"hans@zudempeter.de",
                              "lead_class_ids"=>
                                [@lead_class.id]
                             }
                    }
    end

    @response.status.must_equal 302
    @response.location.must_equal edit_admin_user_url(@user)
  end
end
