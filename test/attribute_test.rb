require 'test_helper'

class AttributeTest < Minitest::Test
  def setup
    @person = Person.new(1, 'nobunaga', 'oda', 30)
  end

  def test_exposing_attribute
    presenter = Class.new(PersonPresenter) do
      attribute :first_name
      attribute :last_name
    end
    expected = { first_name: 'nobunaga', last_name: 'oda' }
    assert_equal expected, presenter.new(@person).to_h
  end

  def test_change_attribute_key
    presenter = Class.new(PersonPresenter) do
      attribute :first_name, key: :given_name
      attribute :last_name, key: :family_name
    end

    expected = { given_name: 'nobunaga', family_name: 'oda' }
    assert_equal expected, presenter.new(@person).to_h
  end

  def test_computed_attribute
    presenter = Class.new(PersonPresenter) do
      attribute :full_name
      def full_name
        "#{object.first_name} #{object.last_name}"
      end
    end

    expected = { full_name: 'nobunaga oda' }
    assert_equal expected, presenter.new(@person).to_h
  end
end
