module Api
  class GatewayErrorResponse < BaseResponse
    def initialize(status)
      super(status, error: '3rd party service error')
    end
  end
end
