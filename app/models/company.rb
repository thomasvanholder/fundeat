class Company < ApplicationRecord
  belongs_to :owner, class_name: "User" # as we did with spotify project. check

  # To use this array in views call it Company::TYPE
  TYPE = ["Restaurant", "Coffe Shop", "Bar"]

end
