class Oystercard
  
  BALANCE_LIMIT = 90
  MINIMUM_FARE = 1


  attr_reader :balance, :entry_station

  def initialize(balance = 0, in_journey = nil)
    @balance = balance
    @in_journey = in_journey
    @entry_station = nil
  end

  def in_journey?
    @in_journey == true
  end

  def touch_in(entry_station)
    fail "Insufficient funds - minimum balance is #{MINIMUM_FARE}" if balance < MINIMUM_FARE
    @in_journey = true
    @entry_station = entry_station
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @in_journey = false
  end

  def top_up(amount)
    fail "Error - maximum balance is #{BALANCE_LIMIT} pounds" if (balance + amount > BALANCE_LIMIT)
    @balance += amount
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
