class Oystercard

  BALANCE_LIMIT = 90
  MINIMUM_FARE = 1


  attr_reader :balance, :journey_history

  def initialize(balance = 0)
    @balance = balance
    @journey_history = []
  end

  def in_journey?
    journey_history.last[:exit_station] == nil
  end

  def touch_in(entry_station)
    fail "Insufficient funds - minimum balance is #{MINIMUM_FARE}" if insufficient_balance?
    @journey_history << { entry_station: entry_station, exit_station: nil }
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    @journey_history.last[:exit_station] = exit_station
  end

  def top_up(amount)
    fail "Error - maximum balance is #{BALANCE_LIMIT} pounds" if balance_exceeded?(amount)
    @balance += amount
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def insufficient_balance?
    balance < MINIMUM_FARE
  end

  def balance_exceeded?(amount)
    balance + amount > BALANCE_LIMIT
  end
end
