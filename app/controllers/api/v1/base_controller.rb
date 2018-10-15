# frozen_string_literal: true

module Api
  module V1
    class BaseController < ActionController::API
      before_action :verify_token!

      private

      def verify_token!
        reply_with Api::UnauthorizedResponse.new unless valid_token?
      end

      def valid_token?
        token_schema.call(params).success?
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
