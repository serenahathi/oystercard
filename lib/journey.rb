class Journey

  attr_reader :entry_station, :exit_station
  MINIMUM_FARE = 1

  def initialize
    @complete = false
  end

  def start(entry_station)
    @entry_station = entry_station
  end

  def finish(exit_station)
    @exit_station = exit_station
  end

  def fare
    MINIMUM_FARE
  end

  def complete?
    @complete
  end

end
