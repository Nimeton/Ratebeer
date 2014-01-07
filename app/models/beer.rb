class Beer < ActiveRecord::Base
 include RatingAverage

  attr_accessible :brewery_id, :name, :style, :style_id

  validates_presence_of :name
  validates_presence_of :style

  belongs_to :brewery 
  belongs_to :style

  has_many :ratings, :dependent => :destroy
  has_many :users, :through => :ratings
  has_many :raters, :through => :ratings, :source => :user

  def to_s
    "#{brewery.name}: #{name}"
  end

end
