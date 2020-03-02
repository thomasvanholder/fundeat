class RemoveStatusFromInvestments < ActiveRecord::Migration[5.2]
  def up
    remove_column :investments, :status
  end
end
