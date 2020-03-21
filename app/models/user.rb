class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, email: true
  validates :date_of_birth, presence: true

  def birthday?
    Date.today.month == date_of_birth.month && Date.today.day == date_of_birth.day
  end

  def send_registration_email
    UserMailer.registration(self).deliver_now
  end
end
