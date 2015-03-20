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
    build = lambda do |query, mem|
      return mem if query.size==0
      term = query.shift
      return build.call(query, mem.where("teams.name LIKE ?","%#{term}%"))
    end

    build.call(query.gsub(/ /, ',').split(',').map(&:strip).reject(&:empty?), self)
  end
end
