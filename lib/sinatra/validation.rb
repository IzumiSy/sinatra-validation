require "sinatra/validation/version"
require "sinatra/errorcodes"
require "dry-validation"

module Sinatra
  module Validation
    module Helpers
      def validates(&block)
        schema = Dry::Validation.Schema(&block)
        validation = schema.call(params)

        if validation.success?
          return validation.output
        end

        if defined?(HTTPError)
          raise HTTPError::BadRequest
        else
          halt 400, 'Bad Request'
        end
      end
    end

    def self.registered(app)
      app.helpers Validation::Helpers
    end
  end
end
