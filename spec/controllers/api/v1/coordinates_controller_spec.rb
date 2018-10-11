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

  xcontext 'blank address' do
    it 'responds with 422' do
      subject
      expect(response.status).to eq(422)
      expect(response.body).to eq({ error: 'unprocessable'}.to_json)
    end
  end

  xcontext 'invalid address' do
    it 'responds with 422' do
      subject
      expect(response.status).to eq(422)
      expect(response.body).to eq({ error: 'unprocessable'}.to_json)
    end
  end

  context '3rd party api error' do
  end

  context 'happy path' do
  end
end
