class CreateRewards < ActiveRecord::Migration[5.2]
  def change
    create_table :rewards do |t|
      t.string :description
      t.integer :investment_amount
      t.references :campaign_id, foreign_key: true

      t.timestamps
    end
  end
end
