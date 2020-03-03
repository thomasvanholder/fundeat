class Campaign < ApplicationRecord
  belongs_to :company
  has_many :investments
  has_many :rewards
end
