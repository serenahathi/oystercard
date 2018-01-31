require 'oystercard'

describe Oystercard do

  subject(:card) { described_class.new }
  let(:entry_station) { double "an entry station" }
  let(:exit_station) { double "an exit station" }
  let(:journey) { { entry_station: entry_station, exit_station: exit_station } }
  # going to be a double for a new instance of journey

  context 'when new card is created' do
    it 'has a balance of 0' do
      expect(card.balance).to eq 0
    end

    it 'has an empty journey history' do
      expect(card.journey_history).to match_array([])
    end
  end

  describe '#touch in' do

    it 'prevents touching in when balance is below one pound' do
      message = "Insufficient funds - minimum balance is #{Oystercard::MINIMUM_BALANCE}"
      expect { card.touch_in(entry_station) }.to raise_error message
    end

  end

  describe '#touch out' do
    before(:each) do
      card.top_up(10)
      card.touch_in(entry_station)
    end

    it 'changes status to false' do
      card.touch_out(exit_station)
      expect(card).not_to be_in_journey
    end

    it 'deducts the minimum fare' do
      expect { card.touch_out(exit_station) }.to change { card.balance }.by(-Oystercard::MINIMUM_BALANCE)
    end

  end

  describe '#top_up' do
    it 'adjusts balance by top up amount' do
      expect { card.top_up(1) }.to change { card.balance }.by(1)
    end

    it 'raises error when Oystercard balance is greater than 90 pounds' do
      card.top_up(Oystercard::BALANCE_LIMIT)
      message = "Error - maximum balance is #{Oystercard::BALANCE_LIMIT} pounds"
      expect { card.top_up(1) }.to raise_error(message)
    end
  end

  # describe '#journey_history' do
  #   it 'shows the entry and exit station for each completed journey' do
  #     card.top_up(50)
  #     card.touch_in(entry_station)
  #     card.touch_out(exit_station)
  #     expect(card.journey_history).to include journey
  #   end
  # end
end