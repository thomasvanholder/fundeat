class Campaign < ApplicationRecord
  belongs_to :company
  has_many :investments
  has_many :rewards

  def raised_sum
    self.investments.reduce(0) { |acum, investment| acum + investment.amount }
  end
end
