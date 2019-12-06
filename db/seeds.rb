# frozen_string_literal: true

require "json"

Dir.chdir("./db")
Dir.each_child("products") do |file|
  data = JSON.parse(File.open("products/#{file}"))
  Product.create(
    name: data["data"]["productDisplayName"],
    description: data["data"]["displayCategories"],
    price: data["data"]["price"]
  )

  p "Product #{data['data']['productDisplayName']} added"
end
