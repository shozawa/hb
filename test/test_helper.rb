$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require "minitest/autorun"
require "hb"

Person = Struct.new(:id, :first_name, :last_name, :age)
class PersonPresenter < Hb::Base; end

