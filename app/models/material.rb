class Material < ApplicationRecord
  belongs_to :lesson

  # Material types: text(0), image(1), pdf(2), link(3)
  enum :material_type, { text: 0, image: 1, pdf: 2, link: 3 }

  has_one_attached :file

  validates :title, presence: true
  validates :material_type, presence: true
end
