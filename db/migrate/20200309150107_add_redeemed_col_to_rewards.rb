class AddRedeemedColToRewards < ActiveRecord::Migration[5.2]
  def change
    add_column :rewards, :redeemed, :boolean
  end
end
