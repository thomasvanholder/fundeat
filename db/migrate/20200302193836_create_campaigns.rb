class CreateCampaigns < ActiveRecord::Migration[5.2]
  def change
    create_table :campaigns do |t|
      t.string :title
      t.string :description
      t.string :repayment_capacity
      t.string :financial_health
      t.string :company_history
      t.string :risk_level
      t.integer :min_target
      t.integer :max_target
      t.integer :loan_duration
      t.float :return_rate
      t.datetime :expiry_date
      t.references :company_id, foreign_key: true

      t.timestamps
    end
  end
end
