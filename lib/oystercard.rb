class Oystercard

  attr_reader :balance, :in_use
  LIMIT = 90
  MIN_VALUE = 0

  def initialize
    @balance = 0
    @in_use = false
  end

  def top_up(amount)
    raise "£#{ LIMIT } limit exceeded" if @balance + amount > LIMIT
    @balance += amount
  end

  def deduct(amount)
    raise "Balance too low" if @balance - amount < MIN_VALUE
    @balance -= amount
  end

  def touch_in
    @in_use = true
  end

  def touch_out
    @in_use = false
  end

  def in_journey?
    @in_use
  end
end
