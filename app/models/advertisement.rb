class Advertisement < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :content, presence: true
  validates :state, presence: true

  scope :published, -> {
    where(state: 'published')
  }
end
