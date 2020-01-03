class Category < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: {case_sensitive: false, scope: :category_id} , if: -> { name.present? }
  validates_with SingleNestingValidator
  has_many :sub_categories, class_name: 'Category', foreign_key: 'category_id', dependent: :destroy
  has_many :products, dependent: :restrict_with_error
  has_many :sub_category_products, class_name: "Product", through: :sub_categories, source: :products, dependent: :restrict_with_error
  belongs_to :category, class_name: "Category", optional: true

  def root?
    !category_id?
  end

  def reset_products_count
    if root?
      self.products_count = products.count + sub_category_products.count
    else
      self.products_count = products.count
      self.category.products_count = category.products.count + category.sub_category_products.count
    end
  end

  def all_products
    products + sub_category_products
  end
end
