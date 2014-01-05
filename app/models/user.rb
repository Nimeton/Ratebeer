class User < ActiveRecord::Base
  include RatingAverage

  attr_accessible :username, :password, :password_confirmation, :admin
  has_secure_password

  validates_uniqueness_of :username
  validates_length_of :password, :minimum => 4
  validates :username, length: { minimum:3, maximum:15 }
  validates_format_of :password, with: /\A.*[^[:alpha:]]+.*\Z/

  has_many :ratings, :dependent => :destroy
  has_many :beers, :through => :ratings
  has_many :memberships, :dependent => :destroy
  has_many :beer_clubs,:through => :memberships

  def favorite_beer
    return nil if ratings.empty?
    ratings.sort_by{ |r| r.score }.last.beer
  end

  def favorite_style
    favorite :style
  end

  def favorite_brewery
    favorite :brewery
  end

  def favorite(attribute)
    return nil if ratings.empty?

    groups = ratings.group_by { |r| r.beer.send attribute }
    groups = average_ratings_for groups
    groups.max_by { |key, avg_rating| avg_rating }[0]
  end

  def average_ratings_for(groups)
    groups.keys.each do |key|
      sum = groups[key].inject(0.0) { |sum, rating| sum + rating.score }
      groups[key] = sum / groups[key].count
    end

    groups
  end

end
