class Category < ApplicationRecord
  has_one  :picture, as: :imageable, dependent: :destroy
  has_many :products

  default_scope { order(title: :asc) }

  accepts_nested_attributes_for :picture
  validates :title, presence: true,
                    length: { in: 2..30 },
                    uniqueness: true
end
