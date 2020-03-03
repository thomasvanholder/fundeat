class FixColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :companies, :type, :type_store
  end
end
