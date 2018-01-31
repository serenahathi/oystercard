require 'station'

describe Station do

  subject(:station) { described_class.new("name", "zone") }

  context 'when creating a new station' do
    it 'has a name' do
      expect(station.name).to eq("name")
    end

    it 'has a zone' do
      expect(station.zone).to eq("zone")
    end
  end


end