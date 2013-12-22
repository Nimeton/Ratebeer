class Beer < ActiveRecord::Base
  attr_accessible :brewery_id, :name, :style

  belongs_to :brewery 
  has_many :ratings, :dependent => :destroy

  def average_rating
    summa = 0
    if ratings.empty?
      return 0
    end
    ratings.each do |rate|
      summa += rate.score
    end
    #return summa/ratings.count
    return ratings.inject(0.0) { |sum, rate|  sum + rate.score } / ratings.count
  end

  def to_s
    "#{brewery.name}: #{name}"
  end

end
