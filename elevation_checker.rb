require 'dstk'
require_relative 'dstk_response'

class ElevationChecker
  attr_accessor :locations, :dstk, :response

  def initialize(locations)
    @locations = locations
    @dstk = DSTK::DSTK.new
  end

  def call!
    @response ||= dstk_call!
  end

  private

  def dstk_call!
    #WINCYJ JAK 560 NIE DA RADY!
    response = dstk.coordinates2statistics(locations, call_opts)
    DSTKResponse.new(response)
  end

  def call_opts
    'elevation'
  end
end
