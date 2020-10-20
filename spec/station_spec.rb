require 'station'

RSpec.describe Station do

  describe '#initialize' do

    it 'sets a name' do
      station = Station.new("St Pancras", 1)
      expect(station.name).to eq "St Pancras"
    end

    it 'sets a zone' do
      station = Station.new("St Pancras", 1)
      expect(station.zone).to eq 1
    end

  end


end
