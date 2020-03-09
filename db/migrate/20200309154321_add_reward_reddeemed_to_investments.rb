class AddRewardReddeemedToInvestments < ActiveRecord::Migration[5.2]
  def change
    add_column :investments, :reward_redeemed, :boolean, defaul: false
  end
end
