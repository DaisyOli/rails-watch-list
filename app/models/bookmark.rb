class Bookmark < ApplicationRecord
  belongs_to :movie
  belongs_to :list

  validates :movie, uniqueness: { scope: :list, message: "has already been added to this list" }
  validates :comment, presence: true, length: { minimum: 6 }
  validates :movie_id, presence: true
end