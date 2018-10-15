# frozen_string_literal: true

module Api
  module V1
    module Coordinates
      class Get
        def self.call(params)
          new(params).call
        end

        def initialize(params)
          @params = params
        end

        def call
          return Api::UnprocessableResponse.new if address_missing?

          coordinates_response
        end

        private

        def address_missing?
          address_schema.call(@params).failure?
        end

        def address_schema
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
          CoordinatesForAddress.call(@params[:address])
        end
      end
    end
  end
end
