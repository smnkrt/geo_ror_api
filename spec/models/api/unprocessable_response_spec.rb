# frozen_string_literal: true

require 'spec_helper'

describe Api::UnprocessableResponse do
  subject { described_class.new }

  describe '#status' do
    it 'returns status value' do
      expect(subject.status).to eq(422)
    end
  end

  describe '#body' do
    it 'returns body value' do
      expect(subject.body).to eq(error: 'unprocessable')
    end
  end
end
