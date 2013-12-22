class Rating < ActiveRecord::Base
  attr_accessible :beer_id, :score

  belongs_to :beers

  def to_s
    "#{Beer.find(beer_id).name} #{score}"
  end
end
