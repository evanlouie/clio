class ConvertStringIpsToIntegers < ActiveRecord::Migration

  def up
    users = User.all
    change_column :users, :current_sign_in_ip, :integer
    change_column :users, :last_sign_in_ip,    :integer
    users.each do |u|
      u.current_sign_in_ip= u[:current_sign_in_ip] if u[:current_sign_in_ip] != nil
      u.last_sign_in_ip= u[:last_sign_in_ip] if u[:last_sign_in_ip] != nil
      u.save
    end
  end

  def down
    users = User.all
    change_column :users, :current_sign_in_ip, :string
    change_column :users, :last_sign_in_ip,    :string
    users.each do |u|
      u.current_sign_in_ip= u[:current_sign_in_ip] if u[:current_sign_in_ip] != nil
      u.last_sign_in_ip= u[:last_sign_in_ip] if u[:last_sign_in_ip] != nil
      u.save
    end
  end
end
