namespace :db do
  desc "assign first category to already existing products"
  task port_legacy_products: :environment do
    first_category = Category.first
    #Product.where(category_id: nil).find_each do |t|
    #  t.update!(category_id: first_category.id)
    #end
    Product.where(category_id: nil).update_all(category_id: first_category.id)
  end

  desc "set user as admin"
  task :set_user_as_admin,[:email] => :environment do |task, args|
    User.where(email: args.email).update_all(role: 'admin')
  end
end
