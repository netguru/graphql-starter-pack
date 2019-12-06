# frozen_string_literal: true

require "json"

Dir.chdir("./db")
Dir.each_child("products") do |file|
  data = JSON.parse(File.read("products/#{file}"))
  category = ProductCategory.find_or_create_by(name: data["data"]["articleType"]["typeName"])

  Product.create(
    name: data["data"]["productDisplayName"],
    description: ActionController::Base.helpers.strip_tags(
      data.dig("data", "productDescriptors", "description", "value")
    ),
    price: data["data"]["price"],
    product_category: category
  )

  p "Product #{data['data']['productDisplayName']} added"
end
