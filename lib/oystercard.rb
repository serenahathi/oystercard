class Oystercard
  
  BALANCE_LIMIT = 90
  BALANCE_MIN = 1

  attr_reader :balance
  def initialize(balance = 0, in_journey = nil)
    @balance = balance
    @in_journey = in_journey
  end

  def in_journey?
    @in_journey == true
  end

  def touch_in
    fail "Insufficient funds - minimum balance is #{BALANCE_MIN}" if balance < BALANCE_MIN 
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  def top_up(amount)
    fail "Error - maximum balance is #{BALANCE_LIMIT} pounds" if (balance + amount > BALANCE_LIMIT)
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end
end