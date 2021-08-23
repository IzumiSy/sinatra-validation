require "sinatra/validation/version"
require "dry-validation"

module Sinatra
  module Validation
    class InvalidParameterError < StandardError
      attr_reader :result

      def initialize(result) 
        @result = result
      end
    end

    class Result
      attr_reader :params, :messages

      def initialize(params)
        @params = params
      end

      def with_message(errors)
        @messages = errors.to_h.map { |key, message| "#{key.to_s} #{message.first}" }
        self
      end
    end

    module Helpers
      def validates(options = {}, &block)
        schema = Class.new(Dry::Validation::Contract, &block).new
        validation = schema.call(params)
        result = Result.new(Sinatra::IndifferentHash[validation.to_h])
          .with_message(validation.errors)

        if options[:filter_unpermitted_params] || settings.filter_unpermitted_params
          params.replace validation.to_h
        end

        if options[:silent] || settings.silent_validation
          return result
        end

        if validation.failure?
          raise InvalidParameterError.new(result)
        end

        result
      rescue InvalidParameterError => exception
        if options[:raise] || settings.raise_sinatra_validation_exception
          raise exception
        end

        errors = exception.result.messages
        error = errors.first

        if content_type && content_type.match(mime_type(:json))
          error = { errors: errors }.to_json
        end

        halt 400, error
      end
    end

    def self.registered(app)
      app.helpers Validation::Helpers
      app.set :silent_validation, false
      app.set :raise_sinatra_validation_exception, false
      app.set :filter_unpermitted_params, false
    end
  end
end
