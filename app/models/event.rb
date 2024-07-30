class Event < ApplicationRecord
  belongs_to :user
  has_many :attendances
  has_many :participants, through: :attendances, source: :user

  validates :start_date, presence: true
  validate :start_date_cannot_be_in_the_past
  validates :duration, presence: true, numericality: { greater_than: 0 }, numericality: { only_integer: true }, numericality: { multiple_of: 5 }
  validates :title, presence: true, length: { minimum: 5, maximum: 140 }
  validates :description, presence: true, length: { minimum: 20, maximum: 1000 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 1000 }
  validates :location, presence: true

  def start_date_cannot_be_in_the_past
    if start_date.present? && start_date < Time.now
      errors.add(:start_date, "can't be in the past")
    end
  end
end
