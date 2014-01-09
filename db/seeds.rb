# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = 100
breweries = 50
beers_in_brewery = 50
ratings_per_user = 30

(1..users).each do |i|
  User.create :username => "user_#{i}", :password => "passwd1", :password_confirmation => "passwd1"
end

(1..breweries).each do |i|
  Brewery.create :name => "brewery_#{i}", :year => 1900, :active => true
end

bulk = Style.create :name => "bulk", :description => "cheap, not much taste"

Brewery.all.each do |b|
  n = rand(beers_in_brewery)
  (1..n).each do |i|
    beer = Beer.create :name => "beer #{b.id} -- #{i}"
    beer.style = bulk
    b.beers << beer
  end
end

User.all.each do |u|
  n = rand(ratings_per_user)
  beers = Beer.all.shuffle
  (1..n).each do |i|
    r = Rating.new :score => (1+rand(50))
    beers[i].ratings << r
    u.ratings << r
  end
end

=begin
b1 = Brewery.create :name => "Koff", :year => 1897
b2 = Brewery.create :name => "Malmgard", :year => 2001
b3 = Brewery.create :name => "Weihenstephaner", :year => 1042

s1 = Style.create :name => "Lager"
s2 = Style.create :name => "Pale ale"
s3 = Style.create :name => "Porter"
s4 = Style.create :name => "Weizen"

be1 = Beer.new :name => "Iso 3"
be2 = Beer.new :name => "Karhu"
be3 = Beer.new :name => "Tuplahumala"
be4 = Beer.new :name => "Huvila Pale ale"
be5 = Beer.new :name => "X Porter"
be6 = Beer.new :name => "Hefezeizen"
be7 = Beer.new :name => "Helles"

s1.beers << be1
s1.beers << be2
s1.beers << be3
s1.beers << be7
s2.beers << be4
s3.beers << be5
s4.beers << be6

b1.beers << be1
b1.beers << be2
b1.beers << be3
b2.beers << be4
b2.beers << be5
b3.beers << be6
b3.beers << be7
=end

