module Api
  module V1
    class CoordinatesController < BaseController
      before_action :verify_address!

      def fetch
        reply_with coordinates_response
      end

      private

      def verify_address!
        reply_with Api::UnprocessableResponse.new if address_present?
      end

      def address_present?
        address_schema.(params).failure?
      end

      def address_schema
        # TODO: address format validation
        Dry::Validation.JSON { required(:address).filled(:str?) }
      end

      def coordinates_response
        Api::BaseResponse.new(200, coordinates_for_address)
      rescue CoordinatesForAddress::GatewayTimeoutError
        Api::GatewayErrorResponse.new(504)
      rescue CoordinatesForAddress::BadGatewayError
        Api::GatewayErrorResponse.new(502)
      end

      def coordinates_for_address
        CoordinatesForAddress.call(params[:address])
      end
    end
  end
end
