class AddcolumnforInvestments < ActiveRecord::Migration[5.2]
  def change
    add_column :investments, :status, :integer
  end
end
