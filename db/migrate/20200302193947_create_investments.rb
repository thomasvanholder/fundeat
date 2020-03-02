class CreateInvestments < ActiveRecord::Migration[5.2]
  def change
    create_table :investments do |t|
      t.integer :amount
      t.string :status
      t.datetime :payment_date
      t.string :stripe_session_id
      t.references :investor, foreign_key: true
      t.references :campaign, foreign_key: true
      t.references :reward, foreign_key: true

      t.timestamps
    end
  end
end
