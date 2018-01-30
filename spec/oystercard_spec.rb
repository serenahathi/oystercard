require 'oystercard'

describe Oystercard do

  subject(:card) { described_class.new }

  describe 'balance' do
    it 'when initialized has a balance of 0' do
      expect(card.balance).to eq 0
    end

    it 'raises error when Oystercard balance is greater than 90 pounds' do
      balance_limit = Oystercard::BALANCE_LIMIT
      card.top_up(balance_limit)
      message = "Error - maximum balance is #{balance_limit} pounds"
      expect { card.top_up(1) }.to raise_error(message)
    end 
  end

  describe '#touch in' do
    it 'changes status to true' do
      card.top_up(10)
      card.touch_in
      expect(card).to be_in_journey
    end

    it 'prevents touching in when balance is below one pound' do
      minimum_balance = Oystercard::BALANCE_MIN
      message = "Insufficient funds - minimum balance is #{minimum_balance}"
      expect { card.touch_in }.to raise_error message
    end
  end

  describe '#touch out' do
    before(:each) do
      card.top_up(10)
      card.touch_in
    end

    it 'changes status to false' do 
      card.touch_out
      expect(card).not_to be_in_journey
    end

    it 'deducts the minimum fare' do
      expect { card.touch_out }.to change { card.balance }.by(-Oystercard::MIN_CHARGE)
    end
  end

  describe '#top_up' do
    it 'adjusts balance by top up amount' do
      expect { card.top_up(1) }.to change { card.balance }.by(1)
    end
  end
end