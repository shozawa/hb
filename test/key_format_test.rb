require 'test_helper'

class KeyFormatTest < Minitest::Test
  def setup
    @person = Person.new(1, 'nobunaga', 'oda', 30)
  end

  def test_transform_keys
    presenter = Class.new(PersonPresenter) do
      attributes :first_name, :last_name
    end
    presenter.key_format :upcase
    expected = { "FIRST_NAME" => 'nobunaga', "LAST_NAME" => 'oda' }
    assert_equal expected, presenter.new(@person).to_h
  end

  def test_transform_keys_with_option
    presenter = Class.new(PersonPresenter) do
      attributes :first_name, :last_name
    end
    presenter.key_format camelize: :lower
    expected = { "firstName" => 'nobunaga', "lastName" => 'oda' }
    assert_equal expected, presenter.new(@person).to_h
  end

  def test_transform_keys_with_proc
    presenter = Class.new(PersonPresenter) do
      attributes :first_name, :last_name
    end
    presenter.key_format ->(k) { "_#{k}"}
    expected = { "_first_name" => 'nobunaga', "_last_name" => 'oda' }
    assert_equal expected, presenter.new(@person).to_h
  end
end