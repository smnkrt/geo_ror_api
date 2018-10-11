require 'rails_helper'

describe Api::V1::CoordinatesController, type: :request do
  subject do
    get api_v1_coordinates_url, params: params, xhr: true
  end

  let(:params) do
    {
      token: token,
      address: address
    }
  end

  let(:token)   { ENV['COORDS_API_TOKEN'] }
  let(:address) { 'some place' }

  before { ENV['COORDS_API_TOKEN'] = 'abcdefg' }

  context 'blank token' do
    let(:token) { nil }
    it_behaves_like 'responds with 401'
  end

  context 'invalid token' do
    let(:token) { 'qwert' }
    it_behaves_like 'responds with 401'
  end

  context 'blank address' do
    let(:address) { nil }
    it_behaves_like 'responds with 422'
  end

  context '3rd party API timeout error' do
    before do
      expect(CoordinatesForAddress)
        .to receive(:call)
        .with(address)
        .and_raise(CoordinatesForAddress::GatewayTimeoutError)
    end

    it 'responds with 504' do
      subject
      expect(response.status).to eq(504)
      expect(response.body).to eq({ error: '3rd party service error'}.to_json)
    end
  end

  context '3rd party api response data format error' do
    before do
      expect(CoordinatesForAddress)
        .to receive(:call)
        .with(address)
        .and_raise(CoordinatesForAddress::BadGatewayError)
    end

    it 'responds with 504' do
      subject
      expect(response.status).to eq(502)
      expect(response.body).to eq({ error: '3rd party service error'}.to_json)
    end
  end

  context 'happy path' do
    let(:coords_data) { { lat: 20.0, lon: 30.0 } }

    before do
      expect(CoordinatesForAddress)
        .to receive(:call)
        .with(address)
        .and_return(coords_data)
    end

    it 'responds with 200 and coordinates' do
      subject
      expect(response.status).to eq(200)
      expect(response.body).to eq(coords_data.to_json)
    end
  end
end
