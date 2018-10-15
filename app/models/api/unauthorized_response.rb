# frozen_string_literal: true

module Api
  class UnauthorizedResponse < BaseResponse
    def initialize
      super(401, error: 'unauthorized')
    end
  end
end
