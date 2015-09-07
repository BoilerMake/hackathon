class School < ActiveRecord::Base
  has_many :users

  def self.hackers
    where(type: 'Hacker')
  end

  def populate_coordinates!
    formatted_name = self.name.gsub(/\s+/,'+')
    response = Net::HTTP.get_response(URI.parse("http://maps.googleapis.com/maps/api/geocode/json?address=#{formatted_name}"))
    parsed = JSON.parse(response.body)
    self.lat = parsed['results'][0]['geometry']['location']['lat']
    self.lng = parsed['results'][0]['geometry']['location']['lng']
    self.save
  end
end
