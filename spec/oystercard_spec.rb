require 'oystercard'

RSpec.describe Oystercard do
  describe '#balance' do
    it 'checks the default balance' do
      expect(subject.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it 'adds money to the oystercard' do
      expect{subject.top_up(5)}.to change{subject.balance}.by(5)
    end

    it 'prevents user from topping up more than 90' do
      expect{subject.top_up(100)}.to raise_error("£90 limit exceeded")
    end
  end

  describe '#deduct' do
    it 'deducts a fare from the balance' do
      subject.top_up(20)
      expect{subject.deduct(3)}.to change{subject.balance}.by(-3)
    end

    it "doesn't allow negative balance" do
      expect{subject.deduct(9999)}.to raise_error "Balance too low"
    end
  end

  describe '#touch_in' do
    it "registers that the person has touched in" do
      subject.top_up(59)
      subject.touch_in
      expect(subject.in_journey?).to eq true
    end

    it 'raises an error when minimum balance is not met' do
      expect{subject.touch_in}.to raise_error("Not enough money")
    end
  end

  describe '#touch_out' do
    it "registers that the person has touched out" do
      subject.top_up(59)
      subject.touch_in
      subject.touch_out
      expect(subject.in_journey?).to eq false
    end
  end

  describe '#in_journey?' do
    it 'returns true if person has touched in' do
      subject.top_up(59)
      subject.touch_in
      expect(subject.in_journey?).to eq true
    end
  end




end
