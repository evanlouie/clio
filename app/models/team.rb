class Team < ActiveRecord::Base
  attr_accessible :name

  has_many :users
  validates_associated :users

  def serializable_hash(options={})
    options = {
      only: [:id, :name]
    }.update(options)
    super(options)
  end


  def self.search(query)
    Team.where("name LIKE ?", "%#{query}%")
  end
end
