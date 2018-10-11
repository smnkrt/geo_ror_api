require 'spec_helper'

describe Api::GatewayErrorResponse do
  subject { described_class.new(status) }
  let(:status) { 502 }

  describe '#status' do
    it 'returns status value' do
      expect(subject.status).to eq(502)
    end
  end

  describe '#body' do
    it 'returns body value' do
      expect(subject.body).to eq({ error: '3rd party service error' })
    end
  end
end
