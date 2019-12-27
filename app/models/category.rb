class Category < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: {case_sensitive: false, scope: :parent_id} , if: -> { name.present? }
  validates_with SingleNestingValidator
  has_many :sub_categories, class_name: 'Category', foreign_key: 'parent_id', dependent: :destroy
  has_many :products, dependent: :restrict_with_error
  has_many :sub_category_products, class_name: "Product", through: :sub_categories, source: :products, dependent: :restrict_with_error
  belongs_to :parent, class_name: "Category", optional: true

  def root?
    parent_id.blank?
  end

  def change_products_count
    self.products_count = products.count + sub_category_products.count
    self.parent.products_count = parent.products.count + parent.sub_category_products.count unless root?
  end
end
