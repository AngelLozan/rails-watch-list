class Movie < ApplicationRecord
  has_many :bookmarks #, dependent: :destroy cannot destroy if is bookmarked
  validates :title, presence: true, uniqueness: true
  validates :overview, presence: true
end
