require 'journey'

describe Journey do

  subject(:journey) { described_class.new }
  let(:entry_station) { double 'an entry station' }
  let(:exit_station) { double 'an exit station' }

  describe 'start' do
    it 'stores the entry station' do
      journey.start(entry_station)
      expect(journey.entry_station).to eq entry_station
    end
  end

  describe 'finish' do
    it 'stores the exit_station' do
      journey.start(entry_station)
      journey.finish(exit_station)
      expect(journey.exit_station).to eq exit_station
    end
  end

  describe '#fare' do
    it 'returns the minimum fare for a journey' do
      expect(journey.fare).to eq Journey::MINIMUM_FARE
    end
  end

  describe '#complete?' do
    it 'returns false when journey is created' do
      expect(journey.complete?).to be false
    end

    it 'returns true when journey is complete' do
      journey.start(entry_station)
      journey.finish(exit_station)
    end
  end

end
