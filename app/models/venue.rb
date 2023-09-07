class Venue < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  # validates :name, :address, :phone_number, presence: true
  belongs_to :user
  has_one_attached :photo
  has_many :gigs

  validates :name, :address, :time, :day_of_the_week, :phone_number, presence: true
end
