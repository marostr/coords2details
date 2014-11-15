require 'rmagick'
require 'addressable/uri'

class TerrainChecker
  include Magick
  attr_accessor :latitude, :longitude, :response

  def initialize(latitude:, longitude:)
    @latitude = latitude
    @longitude = longitude
  end

  def call!
    image = get_image
    color = image.pixel_color(0, 0).to_color
    @response ||= color.eql?(green_color) ? 'water' : 'land'
  end

  private

  def get_image
    ImageList.new(map_image_link)
  end

  def map_image_link
    Addressable::URI.parse(maps_link).normalize.to_s
  end

  def maps_link
    "http://maps.googleapis.com/maps/api/staticmap?scale=1&center=#{latitude},#{longitude}&zoom=100&size=1x1&sensor=false&visual_refresh=true&style=feature:water|color:0x00FF00&style=element:labels|visibility:off&style=feature:transit|visibility:off&style=feature:poi|visibility:off&style=feature:road|visibility:off&style=feature:administrative|visibility:off"
  end

  def green_color
    'green'
  end
end
