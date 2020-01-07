namespace :mailer do
  desc "send all users mail of their orders"
  task send_order_mails: :environment do
    User.includes(:orders).find_each do |user|
      if user.orders.present?
        UserMailer.consolidated_orders_mail(user).deliver_later
      end
    end
  end
end
