class List < ApplicationRecord
  has_one_attached :photo
  has_many :bookmarks, dependent: :destroy # Deletes all bookmarks when list is deleted
  has_many :movies, through: :bookmarks
  has_many :reviews, dependent: :destroy # Deletes all reviews when list is deleted
  validates :name, presence: true, uniqueness: true
end
