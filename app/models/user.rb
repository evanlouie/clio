class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :status, :first_name, :last_name, :web_site, :team_id

  scope :without_user, lambda {|user| where("id <> :id", :id => user.id) }

  belongs_to :team

  STATUSES = {:in => 0, :out => 1}.freeze

  validates :status, :inclusion => {:in => STATUSES.keys}

  def full_name
    [first_name, last_name].join(" ")
  end

  def status=(val)
    write_attribute(:status, STATUSES[val.intern])
  end

  def status
    STATUSES.key(read_attribute(:status))
  end

  def self.search(query)
    build = lambda do |query, mem|
      return mem if query.size==0
      term = query.shift
      return build.call(query, mem.where("users.first_name LIKE ? OR users.last_name LIKE ? OR users.email LIKE ?","%#{term}%", "%#{term}%", "%#{term}%"))
    end

    build.call(query.gsub(/ /, ',').split(',').map(&:strip).reject(&:empty?), self)
  end
end
