class Photo < ApplicationRecord
  belongs_to :user
  belongs_to :event
  has_one_attached :photo do |attachable|
    attachable.variant :common, resize_to_fit: [800, 800]
    attachable.variant :thumb, resize_to_fit: [100, 100]
  end
  scope :persisted, -> { where "id IS NOT NULL" }
end
