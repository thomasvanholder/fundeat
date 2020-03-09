class CreateInvestorRewards < ActiveRecord::Migration[5.2]
  def change
    create_table :investor_rewards do |t|

      t.timestamps
    end
  end
end
