class ConvertStringIpsToIntegers < ActiveRecord::Migration

  def up
    users = User.where('current_sign_in_ip IS NOT NULL OR last_sign_in_ip IS NOT NULL').all
    change_column :users, :current_sign_in_ip, :integer
    change_column :users, :last_sign_in_ip,    :integer
    users.each do |u|
      u.current_sign_in_ip= u[:current_sign_in_ip] unless [nil,''].include?(u[:current_sign_in_ip])
      u.last_sign_in_ip= u[:last_sign_in_ip] unless [nil,''].include?(u[:last_sign_in_ip])
      u.save
    end
  end

  def down
    users = User.where('current_sign_in_ip IS NOT NULL OR last_sign_in_ip IS NOT NULL').all
    change_column :users, :current_sign_in_ip, :string
    change_column :users, :last_sign_in_ip,    :string
    users.each do |u|
      u.current_sign_in_ip= u[:current_sign_in_ip] unless [nil,''].include?(u[:current_sign_in_ip])
      u.last_sign_in_ip= u[:last_sign_in_ip] unless [nil,''].include?(u[:last_sign_in_ip])
      u.save
    end
  end
end
