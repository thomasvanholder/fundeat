class Company < ApplicationRecord
  belongs_to :owner, class_name: "User" # as we did with spotify project. check

  # To use this array in views calle it Company::TYPE
  TYPE = ["Restaurant", "Coffe Shop", "Bar"]

end
