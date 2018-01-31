class Journey

  attr_reader :entry_station, :exit_station
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @complete = false
  end

  def start(entry_station)
    @entry_station = entry_station
  end

  def finish(exit_station)
    @exit_station = exit_station
    change_complete_status
  end

  def fare
    @complete ? MINIMUM_FARE : PENALTY_FARE
  end

  def complete?
    @complete
  end

private

  def change_complete_status
    if !!entry_station && !!exit_station
      @complete = true
    end
  end

end

