require 'oystercard'

describe Oystercard do

  context 'balance' do
    it 'when initialized has a balance of 0' do
      expect(subject.balance).to eq 0
    end
  end

  context 'top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'adjusts balance by top up amount' do
      expect { subject.top_up(1) }.to change { subject.balance }.by(1)
    end
    
  context 'maximum balance' do
    # it 'raises error when Oystercard balance is greater than 90 pounds' do
    #   subject.top_up(80)
    #   expect { subject.top_up(21) }.to raise_error("Error - maximum balance is 90 pounds")
    # end

    it 'raises error when Oystercard balance is greater than 90 pounds' do
      balance_limit = Oystercard::BALANCE_LIMIT
      subject.top_up(balance_limit)
      expect { subject.top_up(1) }.to raise_error("Error - maximum balance of #{balance_limit} pounds")
    end
end  

  end  
end