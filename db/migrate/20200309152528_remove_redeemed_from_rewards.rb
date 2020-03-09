class RemoveRedeemedFromRewards < ActiveRecord::Migration[5.2]
  def change
    remove_column :rewards, :redeemed, :boolean, default: false
  end
end
