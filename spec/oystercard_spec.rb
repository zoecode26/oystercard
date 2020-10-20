require 'oystercard'

RSpec.describe Oystercard do

  # Doubles
  let(:entry_station) {double("Blackfriars", :zone => 1)}
  let(:exit_station) {double("Blackfriars", :zone => 1)}

  describe "#initialize" do
    it "sets the travel_history array to empty by default" do
      expect(subject.travel_history.count).to eq 0
    end
  end

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

  it 'raises an error when minimum balance is not met' do
    expect{subject.touch_in(entry_station)}.to raise_error("Not enough money")
  end

  before(:example) do
    @card = Oystercard.new
    @card.top_up(59)
    @card.touch_in(entry_station)
  end

  describe '#touch_in' do
    it "registers that the person has touched in" do
      expect(@card.in_journey?).to eq true
    end

    it 'remembers the entry station' do
      expect(@card.entry_station).to eq(entry_station)
    end
  end

  describe '#touch_out' do
    it "registers that the person has touched out" do
      @card.touch_out(exit_station)
      expect(@card.in_journey?).to eq false
    end

    it "deduct money after touched out" do
      expect{@card.touch_out(exit_station)}.to change{@card.balance}.by(-1)
    end

    it "adds a journey to travel_history" do
      @card.touch_out(exit_station)
      expect(@card.travel_history).to include({entry_station => exit_station})
    end
  end

  describe '#in_journey?' do
    it 'returns true if person has touched in' do
      expect(@card.in_journey?).to eq true
    end
  end

end
