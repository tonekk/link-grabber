require 'test_helper'

describe Admin::LeadsController do

  setup do
    sign_in_admin
    @lead_class = Fabricate(:lead_class)
    @lead = Fabricate(:lead)

    @lead.lead_class = @lead_class
    @lead.save
  end

  it "should render #index" do
    get :index, {"lead_class_id" => @lead_class.id}
    @response.status.must_equal 200
  end

  it "should render #new" do
    get :new, {"lead_class_id" => @lead_class.id}
    @response.status.must_equal 200
  end

  it "shoud create record" do
    assert_difference ->{@lead_class.reload.leads.count}, +1 do
      post :create, {"lead_class_id" => @lead_class.id,
                      "lead"=>{
                        "first_name"=>"Hans-Peter",
                        "last_name"=>"Schneider",
                        "address_attributes"=>{
                          "street"=>"Hermannstr. 151",
                          "zip"=>"12051",
                          "city"=>"Berlin"
                        }
                      },
                      "lead_data"=>{@lead_class.custom_attributes.first.target=>"A"}
                    }
    end

    @response.status.must_equal 302
    @response.location.must_equal admin_lead_class_leads_url(@lead_class)
  end

  it "should render #edit" do
    get :edit, {id: @lead.id}
    @response.status.must_equal 200
  end

  it "shoud update record" do
    assert_no_difference ->{@lead_class.reload.leads.count} do
      put :update, {"id" => @lead.id,
                     "lead_class_id" => @lead_class.id,
                      "lead"=>{
                        "first_name"=>"Hans-Dieter",
                        "last_name"=>"Schneidereit",
                        "address_attributes"=>{
                          "street"=>"Hermannstr. 152",
                          "zip"=>"12051",
                          "city"=>"Berlin"
                        }
                      },
                      "lead_data"=>{@lead_class.custom_attributes.first.target=>"B"}
                    }
    end

    @response.status.must_equal 302
    @response.location.must_equal edit_admin_lead_url(@lead)
  end
end
