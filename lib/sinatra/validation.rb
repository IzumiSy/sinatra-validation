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
        if silent || settings.silent_validation
          return Result.new(validation.output, errors)
        end
        raise InvalidParameterError.new(params: validation.output, messages: errors)
      rescue InvalidParameterError => exception
        error = exception.to_s

        if content_type && content_type.match(mime_type(:json))
          error = { errors: errors }.to_json
        end

        halt 400, error
      end
    end

    def self.registered(app)
      app.helpers Validation::Helpers
      app.set :silent_validation, false
    end
  end
end
