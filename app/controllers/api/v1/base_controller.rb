module Api
  module V1
    class BaseController < ActionController::API
      before_action :verify_token!

      private

      def verify_token!
        reply_with Api::UnauthorizedResponse.new if token_schema.(params)
      end

      def token_schema
        Dry::Validation.JSON { required(:token).filled(:str?) }
      end

      def reply_with(response)
        render json: response.body.to_json, status: response.status
      end

      def api_token
        ENV['COORDS_API_TOKEN']
      end
    end
  end
end
