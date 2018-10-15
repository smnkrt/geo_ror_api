# frozen_string_literal: true

module Api
  class UnprocessableResponse < BaseResponse
    def initialize
      super(422, error: 'unprocessable')
    end
  end
end
