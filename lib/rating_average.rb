module RatingAverage
  def average_rating
    if ratings.empty?
      return 0
    end
    return ratings.inject(0.0) { |sum, rate|  sum + rate.score } / ratings.count
  end
end
