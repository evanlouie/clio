class Team < ActiveRecord::Base
  attr_accessible :name, :users

  validates :name, length: { minimum: 2 }
  validates :name, uniqueness: true

  has_many :users

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
