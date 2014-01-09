class BeerClub < ActiveRecord::Base
  attr_accessible :city, :founded, :name
  
  validates_presence_of :name, :founded, :city

  has_many :memberships
  has_many :users, :through => :memberships

  def is_member_of_club?(user)
   members = memberships.confirmed.map{ |m| m.user }
   members.include?(user)
  end
end
