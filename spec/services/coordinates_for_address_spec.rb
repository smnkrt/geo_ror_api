require 'rails_helper'

describe CoordinatesForAddress do
  subject { described_class.call(address) }

  let(:address) { 'Capital 12' }

  context 'timeout error while fetching data' do
    before { expect(Net::HTTP).to receive(:get).and_raise(Timeout::Error) }

    it 'raises GatewayTimeoutError' do
      expect { subject }.to raise_error(described_class::GatewayTimeoutError)
    end
  end

  context 'data parse error while fetching data' do
    let(:invalid_json) { '' }

    before { expect(Net::HTTP).to receive(:get).and_return(invalid_json) }

    it 'raises BadGatewayError' do
      expect { subject }.to raise_error(described_class::BadGatewayError)
    end
  end

  context 'multiple results while fetching data' do
    let(:multiple_results) do
      File.open('spec/payloads/multiple_results.json').read
    end

    before { expect(Net::HTTP).to receive(:get).and_return(multiple_results) }

    it 'returns coordinates of the resuls with highest importance' do
      expected = { lat: 55.82741265, lon: 12.3233875105124 }
      expect(subject).to eq(expected)
    end
  end

  context 'single result while fetching data' do
    let(:single_result) { File.open('spec/payloads/single_result.json').read }

    before { expect(Net::HTTP).to receive(:get).and_return(single_result) }

    it 'returns coordinates of the resuls with highest importance' do
      expected = { lat: 55.82741265, lon: 12.3233875105124 }
      expect(subject).to eq(expected)
    end
  end
end
