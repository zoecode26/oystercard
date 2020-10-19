require 'oystercard'

RSpec.describe Oystercard do
  describe '#balance' do
    it 'checks the default balance' do
      oystercard = Oystercard.new
      expect(oystercard.balance).to eq(0)

    end
  end

  describe '#top_up' do
    it 'adds money to the oystercard' do
      oystercard = Oystercard.new
      oystercard.top_up(5)
      expect(oystercard.balance).to eq(5)
    end

    it 'prevents user from topping up more than 90' do
      oystercard = Oystercard.new
      expect{oystercard.top_up(100)}.to raise_error("£90 limit exceeded")
    end
  end

  describe '#deduct' do
    it 'deducts a fare from the balance' do
      oystercard = Oystercard.new
      oystercard.top_up(20)
      oystercard.deduct(3)
      expect(oystercard.balance).to eq(17)
    end 
  end
end
