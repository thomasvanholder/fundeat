class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :investments, foreign_key: "investor_id"
  has_many :companies, foreign_key: "owner_id"

  validates :first_name, presence: true
  validates :last_name, presence: true
  # has_one_attached :photo

end
