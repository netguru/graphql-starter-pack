class Product < ApplicationRecord
   monetize :price_cents, as: :price
   validates :name, :price_cents, presence: true
end
