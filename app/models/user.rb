class User < ApplicationRecord
  before_destroy :check_user_email
  after_destroy :ensure_an_admin_remains
  before_update :check_user_email
  validates :name, presence: true, uniqueness: true
  after_create_commit :welcome_user_mail
  has_secure_password

  private

  def ensure_an_admin_remains
    if User.count.zero?
      raise Error.new "Cant delete last user"
    end
  end

  def welcome_user_mail
    UserMailer.welcome_email(@user).deliver_later
  end

  def check_user_email
    if email == "admin@depot.com"
      raise Error.new "Cant delete or update this user"
    end
  end
end

class Error < StandardError
end
