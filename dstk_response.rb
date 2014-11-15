require 'json'

class DSTKResponse
  attr_accessor :body

  def initialize(body)
    @body = body
    return unless success?
    delete_unnecessary_values
  end

  def success?
    !body.nil?
  end

  def to_json
    body.to_json
  end

  private

  def delete_unnecessary_values
    body.each do |location|
      elevation = location['statistics']['elevation']
      elevation.delete('source_name')
      elevation.delete('description')
    end
  end
end
