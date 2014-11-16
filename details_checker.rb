require_relative 'location_splitter'
require_relative 'elevation_checker'
require_relative 'terrain_checker'

class DetailsChecker
  attr_reader :locations, :services_response

  def initialize(locations)
    @locations = locations
  end

  def call!
    split_locations! unless locations.is_a?(Array)
    check_elevation!
    check_terrain!
    services_response
  end

  private

  def split_locations!
    @locations = LocationSplitter.new(locations).call!
  end

  def check_elevation!
    elevation_checker = ElevationChecker.new(locations)
    @services_response ||= elevation_checker.call!.body
  end

  def check_terrain!
    services_response.each do |location|
      lat = location['location']['latitude']
      long = location['location']['longitude']
      location['statistics']['terrain'] = TerrainChecker.new(latitude: lat, longitude: long).call!
    end
  end
end
