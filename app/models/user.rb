class User < ActiveRecord::Base
  include RatingAverage

  attr_accessible :username, :password, :password_confirmation
  has_secure_password

  validates_uniqueness_of :username
  validates_length_of :password, :minimum => 4
  validates :username, length: { minimum:3, maximum:15 }
  validates_format_of :password, with: /\A.*[^[:alpha:]]+.*\Z/

  has_many :ratings, :dependent => :destroy
  has_many :beers, :through => :ratings
  has_many :memberships, :dependent => :destroy
  has_many :beer_clubs,:through => :memberships

  

end
