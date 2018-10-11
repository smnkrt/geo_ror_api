require 'net/http'

class CoordinatesForAddress
  BadGatewayError = Class.new(StandardError)
  GatewayTimeoutError = Class.new(StandardError)

  def self.call(address)
    new(address).call
  end

  def initialize(address)
    @address = address
  end

  def call
    coordinates
  rescue Timeout::Error
    raise GatewayTimeoutError
  rescue JSON::ParserError
    raise BadGatewayError
  end

  private

  def coordinates
    res = result_data
    { lat: Float(res['lat']), lon: Float(res['lon']) }
  end

  def result_data
    return response_payload if response_payload.is_a?(Hash)
    # NOTE: Select place with highest importance score as we want one result
    response_payload.max_by { |e| e['importance'] }
  end

  def response_payload
    @response_payload ||= JSON.parse(Net::HTTP.get(uri))
  end

  def uri
    URI.parse(endpoint).tap do |u|
      u.query = { key: api_key, q: @address, format: :json }.to_query
    end
  end

  def endpoint
    ENV['COORDS_LOCATIONIQ_ENDPOINT']
  end

  def api_key
    ENV['COORDS_LOCATIONIQ_KEY'].to_s
  end
end
