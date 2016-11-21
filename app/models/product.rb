class Product < ApplicationRecord
  validates :remote_id, :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  update_index 'products#product', :self
end
