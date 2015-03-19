class ConvertStringIpsToIntegers < ActiveRecord::Migration

  def up
    change_column :users, :current_sign_in_ip, :integer
    change_column :users, :last_sign_in_ip,    :integer
    User.all.each.do do |u|
      u.current_sign_in_ip= u.current_sign_in_ip
      u.last_sign_in_ip= u.last_sign_in_ip
      u.save
    end
  end

  def down
    change_column :users, :current_sign_in_ip, :string
    change_column :users, :last_sign_in_ip,    :string
  end
  
end
