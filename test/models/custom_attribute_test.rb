require 'test_helper'

describe CustomAttribute do

  before do
    @custom_attribute = Fabricate.build(:custom_attribute, name: 'test', pretty_name: 'Test')
  end

  it "should return right value for metric :eq" do
    @custom_attribute.metrics = :eq
    build_test_values(@custom_attribute, 'A', 'foo', 'B', 'bar', 'C', 'baz')

    lead = Fabricate(:lead, data: {"test" => 'B'})

    @custom_attribute.get_custom_value_for(lead).must_equal 'bar'
  end

  it "should return right value for metric :gt" do
    @custom_attribute.metrics = :gt
    build_test_values(@custom_attribute, '10', 'foo', '15', 'bar', '20', 'baz')

    lead1 = Fabricate(:lead, data: {"test" => 25})
    lead2 = Fabricate(:lead, data: {"test" => 15})
    lead3 = Fabricate(:lead, data: {"test" => 5})

    # 25 is greater than 20, so 20 should be matched ('baz')
    @custom_attribute.get_custom_value_for(lead1).must_equal 'baz'
    # 15 is equal to 15, so 10 should be matched ('foo')
    @custom_attribute.get_custom_value_for(lead2).must_equal 'foo'
    # 5 is greater than none of the given values, should result in nil
    @custom_attribute.get_custom_value_for(lead3).must_equal nil
  end

  it "should return right value for metric :lt" do
    @custom_attribute.metrics = :lt
    build_test_values(@custom_attribute, '10', 'foo', '15', 'bar', '20', 'baz')

    lead1 = Fabricate(:lead, data: {"test" => 5})
    lead2 = Fabricate(:lead, data: {"test" => 15})
    lead3 = Fabricate(:lead, data: {"test" => 25})

    # 5 is lower than 10, so 10 should be matched ('baz')
    @custom_attribute.get_custom_value_for(lead1).must_equal 'foo'
    # 15 is equal to 15, so 20 should be matched ('baz')
    @custom_attribute.get_custom_value_for(lead2).must_equal 'baz'
    # 25 is lower than none of the given values, should result in nil
    @custom_attribute.get_custom_value_for(lead3).must_equal nil
  end

  it "should return right value for metric :gte" do
    @custom_attribute.metrics = :gte
    build_test_values(@custom_attribute, '10', 'foo', '15', 'bar', '20', 'baz')

    lead1 = Fabricate(:lead, data: {"test" => 25})
    lead2 = Fabricate(:lead, data: {"test" => 15})

    # 25 is greater than 20, so 20 should be matched ('baz')
    @custom_attribute.get_custom_value_for(lead1).must_equal 'baz'
    # 15 is equal to 15, so 15 should be matched ('baz')
    @custom_attribute.get_custom_value_for(lead2).must_equal 'bar'
  end

  it "should return right value for metric :lte" do
    @custom_attribute.metrics = :lte
    build_test_values(@custom_attribute, '10', 'foo', '15', 'bar', '20', 'baz')

    lead1 = Fabricate(:lead, data: {"test" => 5})
    lead2 = Fabricate(:lead, data: {"test" => 15})

    # 5 is lower than 10, so 10 should be matched ('foo')
    @custom_attribute.get_custom_value_for(lead1).must_equal 'foo'
    # 15 is equal to 15, so 15 should be matched ('bar')
    @custom_attribute.get_custom_value_for(lead2).must_equal 'bar'
  end

  def build_test_values(custom_attribute, one, one_css, two, two_css, three, three_css)
    Fabricate.build(:custom_value, value: one, css: one_css, custom_attribute: custom_attribute)
    Fabricate.build(:custom_value, value: two, css: two_css, custom_attribute: custom_attribute)
    Fabricate.build(:custom_value, value: three, css: three_css, custom_attribute: custom_attribute)
  end
end
