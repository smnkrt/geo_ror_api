module Api
  module V1
    class BaseController < ActionController::API
      before_action :verify_token!

      private

      def verify_token!
        reply_with Api::UnauthorizedResponse.new if invalid_schema?
      end

      def invalid_schema?
        token_schema.(params).failure?
      end

      def token_schema
        Dry::Validation.JSON do
          required(:token).filled(eql?: ENV['COORDS_API_TOKEN'])
        end
      end

      def reply_with(response)
        render json: response.body.to_json, status: response.status
      end
    end
  end
end
