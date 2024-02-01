class Order < ApplicationRecord
    belongs_to :user
    has_many :order_has_products, dependent: :destroy
    has_many :products, through: :order_has_products
    accepts_nested_attributes_for :order_has_products 
    before_create :set_num_order

    private

    #Genera consecutivos para el campo num_order
    def set_num_order
        last_order = Order.order(num_order: :desc).first
        self.num_order = last_order ? last_order.num_order + 1 : 1
    end
end
