class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :investments, foreign_key: "investor_id"
  has_many :companies, foreign_key: "owner_id"
  has_one_attached :photo # we might be willing to change it to many. and check how to define which one to show on prod cards that only allow one photo for the time being.


  validates :first_name, presence: true
  validates :last_name, presence: true
  # has_one_attached :photo

end
