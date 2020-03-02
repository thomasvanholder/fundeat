class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :type
      t.string :address
      t.float :longitude
      t.float :latitude
      t.integer :num_employees
      t.string :instagram_url
      t.string :tripadvisor_url
      t.string :googlereview_url
      t.string :description
      t.bigint :owner_id, foreign_key: true

      t.timestamps
    end
  end
end
