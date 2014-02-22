require 'test_helper'

describe CustomValue do

  it "Should return a number if value is numeric" do
    @custom_value = Fabricate.build(:custom_value, value: 'A', css: 'foo')

    @custom_value.value.must_equal 'A'

    @custom_value.value = '25'

    @custom_value.value.must_equal 25.0
  end
end
