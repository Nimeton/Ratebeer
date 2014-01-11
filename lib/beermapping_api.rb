class BeermappingAPI
  def self.places_in(city)
    Place # varmistaa, että luokan koodi on ladattu
    Time

    city = city.downcase
    Rails.cache.write city, [fetch_places_in(city), Time.now] if not Rails.cache.exist? city or (Rails.cache.read city)[1] < 1.hour.ago

    (Rails.cache.read city)[0]
  end


  def self.fetch_places_in(city)
    url = "http://beermapping.com/webservice/loccity/#{key}/"

    response = HTTParty.get "#{url}#{city.gsub(' ', '%20')}"
    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) and places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.inject([]) do | set, place |
      set << Place.new(place)
    end
  end

  def self.key
    Settings.beermapping_apikey
  end

  def self.scores_in(id)
    Place
    Time

    Rails.cache.write id, [fetch_scores_in(id), Time.now] if not Rails.cache.exist? id or (Rails.cache.read id)[1] < 1.hour.ago

    (Rails.cache.read id)[0]
  end

  def self.fetch_scores_in(id)
    url = "http://beermapping.com/webservice/locscore/#{key}/#{id}"

    response = HTTParty.get "#{url}"
    scores = response.parsed_response["bmp_locations"]["location"]

    scores
  end  

end
