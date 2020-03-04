class ChangeUserTypeInUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :user_type, :string
    add_column :users, :owner, :boolean
  end
end
