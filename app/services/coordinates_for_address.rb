# frozen_string_literal: true

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
    coordinates_response
  rescue Timeout::Error
    raise GatewayTimeoutError
  rescue JSON::ParserError
    raise BadGatewayError
  end

  private

  NUM_OF_DIGITS = 4
  private_constant :NUM_OF_DIGITS

  def coordinates_response
    res = result_data
    return res if res['error'].present?

    { lat: coord(res['lat']), lon: coord(res['lon']) }
  end

  def coord(val)
    Float(val).round(NUM_OF_DIGITS)
  end

  def result_data
    return response_payload if single_result_response?
    response_payload.max_by { |e| e['importance'] }
  end

  def single_result_response?
    response_payload.is_a?(Hash)
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
