class User < ApplicationRecord
  has_many :events
  has_many :attendances
  has_many :attended_events, through: :attendances, source: :event

  validates :email, presence: true, uniqueness: true
  validates :encrypted_password, presence: true

  after_create :send_welcome_email

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now
  end
end
