class Investment < ApplicationRecord
  belongs_to :investor, class_name: "User"
  belongs_to :campaign
  belongs_to :reward

  # This enumerable saves integer to database but retrieves the symbol in the model
  enum status: { pending: 0, on_transit: 1, delivered: 2, canceled: 3, refunded: 4 }
end
