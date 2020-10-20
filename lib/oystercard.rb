class Oystercard

  attr_reader :balance, :in_use, :entry_station, :travel_history
  LIMIT = 90
  MIN_VALUE = 0
  MIN_FARE = 1

  def initialize
    @balance = 0
    @entry_station = nil
    @travel_history = []
  end

  def top_up(amount)
    raise "£#{ LIMIT } limit exceeded" if over_limit?(amount)
    @balance += amount
  end

  def touch_in(entry)
    raise "Not enough money" if under_limit?(MIN_FARE)
    @entry_station = entry
  end

  def over_limit?(a)
    @balance + a > LIMIT
  end

  def under_limit?(a)
    @balance - a < MIN_VALUE
  end

  def touch_out(exit_station)
    deduct(MIN_FARE)
    single_trip = {}
    single_trip[@entry_station] = exit_station
    @travel_history << single_trip
    @entry_station = nil
  end

  def in_journey?
    !(@entry_station.nil?)
  end

  def deduct(amount)
    raise "Balance too low" if under_limit?(amount)
    @balance -= amount
  end

  private :deduct, :over_limit?, :under_limit?


end
