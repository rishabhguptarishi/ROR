json.extract! product, :title
json.extract! product.category, :name
json.url product_url(product, format: :json)
