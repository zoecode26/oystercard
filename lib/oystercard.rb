class Oystercard

  attr_reader :balance, :in_use
  LIMIT = 90
  MIN_VALUE = 0
  MIN_FARE = 1

  def initialize
    @balance = 0
    @in_use = false
  end

  def top_up(amount)
    raise "£#{ LIMIT } limit exceeded" if over_limit?(amount)
    @balance += amount
  end

  def touch_in
    raise "Not enough money" if under_limit?(MIN_FARE)
    @in_use = true
  end

  def over_limit?(a)
    @balance + a > LIMIT
  end

  def under_limit?(a)
    @balance - a < MIN_VALUE
  end

  def touch_out
    @in_use = false
    deduct(MIN_FARE)
  end

  def in_journey?
    @in_use
  end

  def deduct(amount)
    raise "Balance too low" if under_limit?(amount)
    @balance -= amount
  end

  private :deduct

end
