module Api
  module V1
    class CoordinatesController < BaseController
      before_action :verify_address!

      def fetch
      end

      private

      def verify_address!
        reply_with Api::UnprocessableResponse.new if address_present?
      end

      def address_present?
        address_schema.(params).failure?
      end

      def address_schema
        Dry::Validation.JSON { required(:address).filled(:str?) }
      end
    end
  end
end
