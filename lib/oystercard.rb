class Oystercard
  
  BALANCE_LIMIT = 90

  attr_reader :balance

  def initialize(balance = 0)
    @balance = balance
  end

  def top_up(amount)
    fail "Error - maximum balance of #{BALANCE_LIMIT} pounds" if (@balance + amount > BALANCE_LIMIT)
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end
end