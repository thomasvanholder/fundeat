class DropInvestorRewards < ActiveRecord::Migration[5.2]
  def up
    drop_table :investor_rewards
  end
end
