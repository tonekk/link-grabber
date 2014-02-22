require 'test_helper'

describe Admin::LeadClassesController do

  setup do
    sign_in_admin
    @lead_class = Fabricate(:lead_class)
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
    assert_difference ->{LeadClass.all.count}, +1 do
      post :create, {"lead_class"=>{
                      "name"=>"Doctor",
                      "street_col"=>"A",
                      "city_col"=>"B",
                      "zip_col"=>"C",
                      "custom_attributes_attributes"=>{
                        "0"=>{
                          "name"=>"foo",
                          "pretty_name"=>"FooTranslated",
                          "target"=>"size",
                          "xls_col"=>"D",
                          "metrics"=>"eq",
                          "custom_values_attributes"=>{
                           "1392913761526"=>{
                            "value"=>"1",
                            "css"=>"100",
                            "_destroy"=>"false"}
                          },
                          "_destroy"=>"false"
                        }
                      }
                    }
                  }
    end

    @response.status.must_equal 302
    @response.location.must_equal admin_lead_classes_url
  end

  it "should render #edit" do
    get :edit, id: @lead_class.id
    @response.status.must_equal 200
  end

  it "shoud update record" do
    assert_no_difference ->{LeadClass.all.count} do
      post :update, {"id" => @lead_class.id,
                     "lead_class"=>{
                      "name"=>"Doctor",
                      "street_col"=>"A",
                      "city_col"=>"B",
                      "zip_col"=>"C",
                      "custom_attributes_attributes"=>{
                        "0"=>{
                          "name"=>"bar",
                          "pretty_name"=>"BarTranslated",
                          "target"=>"background-color",
                          "xls_col"=>"E",
                          "metrics"=>"eq",
                          "custom_values_attributes"=>{
                           "1"=>{
                            "value"=>"1",
                            "css"=>"#FFF",
                            "_destroy"=>"false"}
                          },
                          "_destroy"=>"false"
                        }
                      }
                    }
                  }
    end

    @response.status.must_equal 302
    @response.location.must_equal edit_admin_lead_class_url(@lead_class)
  end
end
