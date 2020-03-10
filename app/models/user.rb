class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  has_many :investments, foreign_key: "investor_id"
  has_one :company, foreign_key: "owner_id"
  has_one_attached :photo # we might be willing to change it to many. and check how to define which one to show on prod cards that only allow one photo for the time being.


  validates :first_name, presence: true
  validates :last_name, presence: true
  # has_one_attached :photo

  # after_create :send_welcome_email
  def campaign
    company.campaign
  end

  private

  # def send_welcome_email
  #   UserMailer.with(user: self).welcome.deliver_now
  # end

end
