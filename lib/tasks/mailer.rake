namespace :mailer do
  desc "send all users mail of their orders"
  task send_order_mails: :environment do
    users = User.all.includes(:orders)
    users.each do |user|
      UserMailer.consolidated_orders_mail(user).deliver_later
    end
  end
end
