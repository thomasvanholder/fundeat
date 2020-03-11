class Campaign < ApplicationRecord
  belongs_to :company
  has_many :investments
  has_many :investors, through: :investments
  has_many :rewards
  #belongs_to :owner, class_name: "User"


  def raised_sum
    self.investments.reduce(0) { |acum, investment| acum + investment.amount }
  end

  def to_go
    self.min_target - raised_sum
  end

  def progress_percentage
    if min_target.to_f == 0
      return 0
    else
      ((raised_sum.to_f / min_target.to_f) * 100).round(0)
    end
  end
end

