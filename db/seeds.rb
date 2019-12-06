# frozen_string_literal: true

require "json"

Dir.chdir("./db")
Dir.each_child("products") do |file|
  data = JSON.parse(File.read("products/#{file}"))
  Product.create(
    name: data["data"]["productDisplayName"],
    description: ActionController::Base.helpers.strip_tags(
      data.dig("data", "productDescriptors", "description", "value")
    ),
    price: data["data"]["price"]
  )

  p "Product #{data['data']['productDisplayName']} added"
end
