class Oystercard

  attr_reader :balance
  LIMIT = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "£#{ LIMIT } limit exceeded" if @balance + amount > LIMIT
    @balance += amount
  end

  def deduct(amount)
    # Remember to not allow negative values
    @balance -= amount
  end
end
