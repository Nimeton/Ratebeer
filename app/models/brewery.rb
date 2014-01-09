class Brewery < ActiveRecord::Base
 include RatingAverage
  attr_accessible :name, :year, :active

  validates_presence_of :name
  validate :correct_year

  scope :active, where(:active => true)
  scope :retired, where(:active => [nil, false])

  def correct_year
    unless (1042..Date.today.year).include? year
      errors.add(:year, "must be between 1042 and this year")
    end
  end

  def self.top(n)
    sorted_by_rating_in_desc_order = Brewery.all.sort_by{ |b| -b.average_rating }.first(n)
  end

  has_many :beers
  has_many :ratings, :through => :beers

end
