require 'oystercard'

describe Oystercard do

  subject(:card) { described_class.new}

  describe 'card' do
    it 'has a default status of' do
    expect(card).to have_attributes(:balance => 0)
    end
  end

  describe '#touch in' do
    it { is_expected.to respond_to(:touch_in) }

    it 'changes status to true' do
      card.touch_in
      expect(card).to be_in_journey
    end
  end

  describe '#touch out' do
    it { is_expected.to respond_to(:touch_out) }

    it 'changes status to false' do
      card.touch_in  
      card.touch_out
      expect(card).not_to be_in_journey
    end
  end

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

  describe '#top_up' do
    it 'adjusts balance by top up amount' do
      expect { card.top_up(1) }.to change { card.balance }.by(1)
    end
  end
     
  describe '#deduct' do
    it 'deducts fare' do
      card.top_up(10)
      expect { card.deduct(5) }.to change { card.balance }.by(-5)
    end


  end

end