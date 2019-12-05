require "json"

Dir.chdir("./db")
puts Dir.pwd
Dir.each_child("products") do |file|
  data = JSON.load(File.open("products/#{file}"))
  Product.create(name: data["data"]["productDisplayName"], description: data["data"]["displayCategories"])
  p "Product #{data["data"]["productDisplayName"]} added"
end
