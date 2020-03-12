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

  def expired?
    ((expiry_date - Time.now)/86400) < 0
  end


 #Note HK - Risklevel: this way risk level is shown in the show page. (i am just commenting it as Julius will be trying to fix it directly on the database)
   # def total_risk_level
  #   char_array = []
  #   char_array << repayment_capacity
  #   char_array << financial_health
  #   char_array << company_history
  #   string = char_array.join.gsub!(/[ABC]/, 'A' => 1, 'B' => 2, 'C' => 3)
  #   num_array = string.split(//)
  #   sum = 0
  #   num_array.each { |i| sum += i.to_i }
  #   average = (sum / 3).round(0).to_s
  #   self.risk_level = average.gsub!(/[123]/, '1' => 'A', '2' => 'B', '3' => 'C')

  # end

end

