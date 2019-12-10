# frozen_string_literal: true

require "json"

Dir.chdir("./db")
Dir.each_child("products") do |file|
  data = JSON.parse(File.read("products/#{file}"))
  category = ProductCategory.find_or_create_by(name: data["data"]["articleType"]["typeName"])

  product = Product.create(
    name: data["data"]["productDisplayName"],
    description: ActionController::Base.helpers.strip_tags(
      data.dig("data", "productDescriptors", "description", "value")
    ),
    price: data["data"]["price"],
    product_category: category
  )

  values = %w[#ff0000 #00ff00 #0000ff]
  %w[red green blue].each_with_index do |color, i|
    ProductVariant.create(
      product: product,
      variant_type: "color",
      value: values[i],
      label: color
    )
  end

  p "Product #{data['data']['productDisplayName']} added"
end

cart = Cart.first_or_create
p "Cart created"

10.times do 
  product = Product.order('RANDOM()').first
  cart.cart_items.create(product: product, product_variant_id: product.product_variant_ids.sample)
end

p "Cart items created"