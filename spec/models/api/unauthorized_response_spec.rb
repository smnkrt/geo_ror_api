require 'spec_helper'

describe Api::UnauthorizedResponse do
  subject { described_class.new }

  describe '#status' do
    it 'returns status value' do
      expect(subject.status).to eq(401)
    end
  end

  describe '#body' do
    it 'returns body value' do
      expect(subject.body).to eq({ error: 'unauthorized' })
    end
  end
end
