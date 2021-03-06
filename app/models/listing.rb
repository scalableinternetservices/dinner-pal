class Listing < ApplicationRecord
  belongs_to :user, foreign_key: 'chef_id'
  has_many :reservations, foreign_key: 'listing_id', dependent: :destroy
  has_many :reviews, foreign_key: 'listing_id', dependent: :destroy
  has_many_attached :images

  after_initialize :set_default_availability, :if => :new_record?

  include PgSearch::Model
  pg_search_scope :search_for, against: %i(title description)

  def set_default_availability
    self[:reserved?] ||= false
  end

  def set_availability(reserved)
    self[:reserved?] = reserved
    self.save
  end
end
