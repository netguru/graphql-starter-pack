require 'search_object'
require 'search_object/plugin/graphql'

class Resolvers::ProductSearch
  include SearchObject.module(:graphql)

  scope { Product.all }

  type types[Types::ProductType]

  class ProductFilter < ::Types::BaseInputObject
    argument :OR, [self], required: false
    argument :name_contains, String, required: false
    argument :description_contains, String, required: false
    argument :price_min, Integer, required: false
    argument :price_max, Integer, required: false
  end

  option :filter, type: ProductFilter, with: :apply_filter
  option :first, type: types.Int, with: :apply_first
  option :skip, type: types.Int, with: :apply_skip

  def apply_filter(scope, value)
    branches = normalize_filters(value).reduce { |a, b| a.or(b) }
    scope.merge branches
  end

  def apply_first(scope, value)
    scope.limit(value)
  end

  def apply_skip(scope, value)
    scope.offset(value)
  end

  def normalize_filters(value, branches = [])
    scope = Product.all
    scope = scope.where('name LIKE ?', "%#{value[:name_contains]}%") if value[:name_contains]
    scope = scope.where('description LIKE ?', "%#{value[:description_contains]}%") if value[:description_contains]
    scope = scope.where('price_cents >= ?', "#{value[:price_min].to_money.cents}") if value[:price_min]
    scope = scope.where('price_cents <= ?', "#{value[:price_max].to_money.cents}") if value[:price_max]

    branches << scope

    value[:OR].reduce(branches) { |s, v| normalize_filters(v, s) } if value[:OR].present?

    branches
  end
end
