class Brewery < ActiveRecord::Base
 include RatingAverage
  attr_accessible :name, :year

  validates_presence_of :name
  validate :correct_year

  def correct_year
    unless (1042..Date.today.year).include? year
      errors.add(:year, "must be between 1042 and this year")
    end
  end

  has_many :beers
  has_many :ratings, :through => :beers

end
