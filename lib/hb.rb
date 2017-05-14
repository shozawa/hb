require "hb/version"
require "hb/key_formatter"
require "active_support/core_ext/class"
require "active_support/core_ext/array"

module Hb
  class Base
    attr_reader :object, :instance_options
    class_attribute :_attributes_data, :key_formatter
    self._attributes_data = {}
    self.key_formatter = nil

    def initialize(object, options = {})
      @object = object
      @instance_options = options
    end

    class << self
      def attributes(*args)
        args.each do |attr|
          attribute(attr)
        end
      end

      def attribute(attr, options = {})
        key = options.fetch(:key, attr)
        # https://apidock.com/rails/Class/class_attribute
        self._attributes_data = _attributes_data.merge({ key => attr })
      end

      def key_format(*args)
        self.key_formatter = KeyFormatter.new(*args)
      end
    end

    def to_hash
      hash = self.class._attributes_data.each_with_object({}) do |(key, attr), result|
        if respond_to?(attr)
          result[key] = send(attr)
        else
          result[key] = object.send(attr)
        end
      end

      format(hash)
    end

    alias :to_h :to_hash

    private

    def format(hash)
      return hash unless self.class.key_formatter

      hash.deep_transform_keys do |k|
        self.class.key_formatter.format(k)
      end
    end
  end
end
