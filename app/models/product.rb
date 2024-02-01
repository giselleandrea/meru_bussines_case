class Product < ApplicationRecord
    has_many :order_has_products
    has_many :orders, through: :order_has_products

    validates :name, presence: true
    validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

    


end
