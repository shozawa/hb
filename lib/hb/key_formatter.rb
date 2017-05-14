module Hb
  class Base
    class KeyFormatter
      def initialize(*args)
        @format = {}

        options = args.extract_options!
        args.each do |name|
          @format[name] = []
        end
        options.each do |name, parameters|
          @format[name] = parameters
        end
      end

      def format(key)
        @format.reduce(key.to_s) do |result, args|
          func, args = args
          if ::Proc === func
            func.call result, *args
          else
            result.send func, *args
          end
        end
      end
    end
  end
end
