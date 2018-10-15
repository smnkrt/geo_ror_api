module Api
  module V1
    class CoordinatesController < BaseController
      def fetch
        reply_with Api::V1::Coordinates::Get.call(params)
      end
    end
  end
end
