# frozen_string_literal: true

require 'spec_helper'

describe Api::BaseResponse do
  subject { described_class.new(status, body) }
  let(:status) { 200 }
  let(:body) { '{}' }

  describe '#status' do
    it 'returns status value' do
      expect(subject.status).to eq(status)
    end
  end

  describe '#body' do
    it 'returns body value' do
      expect(subject.body).to eq(body)
    end
  end
end
