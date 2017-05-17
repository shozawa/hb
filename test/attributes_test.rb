require 'test_helper'

class AttributesTest < Minitest::Test
  def setup
    @person = Person.new(1, 'nobunaga', 'oda', 30)
  end

  def test_exposing_attributes
    presenter = Class.new(PersonPresenter) do
      attributes :first_name, :last_name, :age
    end
    expected = { first_name: 'nobunaga', last_name: 'oda', age: 30 }
    assert_equal expected, presenter.new(@person).to_h
  end
end