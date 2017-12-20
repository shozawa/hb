require 'test_helper'

class FactriesTest < Minitest::Test
  def setup
    @person = Person.new(1, 'nobunaga', 'oda', 30)
    @people = [
      Person.new(1, 'nobunaga', 'oda', 30),
      Person.new(2, 'ieyasu', 'tokugawa', 50),
    ]
  end

  def test_wrap
    presenter = Class.new(PersonPresenter) do
      attributes :first_name, :last_name, :age
    end
    expected = { first_name: 'nobunaga', last_name: 'oda', age: 30 }
    assert_equal expected, presenter.wrap(@person)
  end

  def test_collection
    presenter = Class.new(PersonPresenter) do
      attributes :first_name, :last_name, :age
    end
    expected = [
      { first_name: 'nobunaga', last_name: 'oda', age: 30 },
      { first_name: 'ieyasu', last_name: 'tokugawa', age: 50 }
    ]
    assert_equal expected, presenter.collection(@people)
  end
end