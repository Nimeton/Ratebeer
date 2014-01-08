# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
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
