class Product < ApplicationRecord
   monetize :price_cents, as: :price
end
