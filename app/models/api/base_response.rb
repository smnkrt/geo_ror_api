# frozen_string_literal: true

module Api
  class BaseResponse
    attr_reader :status, :body

    def initialize(status, body)
      @status = status
      @body = body
    end
  end
end
