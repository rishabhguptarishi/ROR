class OrderMailer < ApplicationMailer
  default from: 'Sam Ruby <depot@example.com>'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.received.subject
  #
  def received(order)
    @order = order
    order.line_items.each do |line_item|
      image_url = line_item.product.image_url
      attachments[image_url] = File.read(image_url)
    end
    I18n.with_locale(@order.user.language) do
      mail to: order.email, subject: I18n.t('order_mailer.recieved.subject')
    end
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.shipped.subject
  #
  def shipped(order)
    @order = order
    mail to: order.email, subject: 'Pragmatic Store Order shipped'
  end
end
