class LocationSplitter
  attr_accessor :locations

  def initialize(locations)
    @locations = locations
  end

  def call!
    split_locations!
    locations
  end

  private

  def split_locations!
    self.locations = locations.split(':')
    locations.map!{ |location| location.split(',') }
    locations.map! do |location|
      location.map! do |coord|
        coord.to_f
      end
    end
  end
end
