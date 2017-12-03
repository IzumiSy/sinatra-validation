require "sinatra/validation/version"
require "dry-validation"

module Sinatra
  module Validation
    class InvalidParameterError < StandardError
      attr_accessor :params, :messages
    end

    class Result < Struct.new("Result", :params, :messages)
    end

    module Helpers
      def validates(silent = false, &block)
        schema = Dry::Validation.Schema(&block)
        validation = schema.call(params)

        if validation.success?
          return Result.new(validation.output)
        end

        errors = validation.messages(full: true).values.flatten;
        return Result.new(validation.output, errors) if silent
        raise InvalidParameterError.new(params: validation.output, messages: errors)
      end
    end

    def self.registered(app)
      app.helpers Validation::Helpers
    end
  end
end
