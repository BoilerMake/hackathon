class School < ActiveRecord::Base
  has_many :hackers
  belongs_to :transportation_method

  def populate_coordinates!
    formatted_name = self.name.gsub(/\s+/,'+').gsub(/\P{ASCII}/, '')
    response = Net::HTTP.get_response(URI.parse("http://maps.googleapis.com/maps/api/geocode/json?address=#{formatted_name}"))
    parsed = JSON.parse(response.body)
    if parsed['results'].length > 0
      self.lat = parsed['results'][0]['geometry']['location']['lat']
      self.lng = parsed['results'][0]['geometry']['location']['lng']
      self.save
    end
  end
end
