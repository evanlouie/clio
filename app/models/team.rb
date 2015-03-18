class Team < ActiveRecord::Base
  attr_accessible :name

  has_many :users
  validates_associated :users

  def self.search(query)
    Team.where("name LIKE ?", "%#{query}%")
  end
end
