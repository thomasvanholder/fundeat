class AddCurrencyToInvestments < ActiveRecord::Migration[5.2]
  def change
    add_monetize :investments, :amount, currency: { present: false }
  end
end
