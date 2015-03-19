class ConvertStringIpsToIntegers < ActiveRecord::Migration

  def up
    users = User.all
    change_column :users, :current_sign_in_ip, :integer
    change_column :users, :last_sign_in_ip,    :integer
    users.each{ |u| u.save }
  end

  def down
    users = User.all
    change_column :users, :current_sign_in_ip, :string
    change_column :users, :last_sign_in_ip,    :string
    users.each{ |u| u.save }
  end

end
