require 'test_helper'

describe User do

  before do
    # Fabricate stuff
    @user = Fabricate(:user)
    @lead_class = Fabricate(:lead_class)
    @custom_attribute = @lead_class.custom_attributes.first
    @custom_attribute2 = Fabricate.build(:custom_attribute, name: 'second_attribute', target: 'background-color', metrics: :eq)
    # Glue it together
    @lead_class.custom_attributes << @custom_attribute2
    @user.lead_classes = [@lead_class]


    # Leads are create with attribute (for the first custom attribute [see fabricator])
    # and value 2, because metrics is :gt
    # and second_attribute (for second custom attribute)
    # and value 1, because metrics is :eq
    3.times { lead = Fabricate(:lead, data: {attribute: '2', second_attribute: '1'}) }
    @lead_class.leads = Lead.all.to_a
    @user.leads = Lead.all.to_a
    @lead_class.save
    @user.save

    @custom_value = Fabricate(:custom_value, value: '1', css: '20', custom_attribute: @custom_attribute)
    @custom_value2 = Fabricate(:custom_value, value: '1', css: '#FFF', custom_attribute: @custom_attribute2)

  end

  # NOTE: Test name is not really descriptive
  # as we are not really checking validity
  it "should output valid css & js" do
    # Get some leads going

    # Get styles and js
    styles, js = @user.custom_styles_and_js

    # All lead ids should be in there
    @user.leads.each do |lead|
      styles.must_include lead.id
      js.must_include lead.id
    end

    # custom_attribute2 has a css target ('background-color')
    styles.must_include @custom_attribute2.target
    # custom_attribute has a js target ('size')
    js.must_include @custom_attribute.target
  end

end
