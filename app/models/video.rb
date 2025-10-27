class Video < ApplicationRecord
  belongs_to :lesson

  has_one_attached :video_file

  validates :title, presence: true
  validates :duration, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
end
