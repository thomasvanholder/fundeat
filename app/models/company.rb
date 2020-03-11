class Company < ApplicationRecord
  belongs_to :owner, class_name: "User" # as we did with spotify project. check
  has_one :campaign
  has_many :investments, through: :campaign
  has_one_attached :photo # we might be willing to change it to many. and check how to define which one to show on prod cards that only allow one photo for the time being.

  geocoded_by :address
  after_validation :geocode
  # To use this array in views calle it Company::TYPE
  # TYPE = ["Restaurant", "Coffe Shop", "Bar"]

  def number_of_investors
    investments.where.not(payment_date: nil).count(:investor_id)
  end
end
