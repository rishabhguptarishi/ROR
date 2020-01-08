require 'URI'
class User < ApplicationRecord
  before_destroy :check_if_restricted_by_email
  after_destroy :ensure_an_admin_remains
  before_update :check_if_restricted_by_email
  validates :name, presence: true, uniqueness: {case_sensitive: false}
  validates :email, presence: true, uniqueness: {case_sensitive: false}, format: { with: URI::MailTo::EMAIL_REGEXP }
  after_create_commit :welcome_user_mail
  has_many :orders, dependent: :destroy
  has_one :address, dependent: :destroy
  has_many :ratings
  accepts_nested_attributes_for :address, allow_destroy: true
  has_secure_password

  private def ensure_an_admin_remains
    if User.count.zero?
      raise Error.new "Cant delete last user"
    end
  end

  private def welcome_user_mail
    UserMailer.welcome_email(self).deliver_later
  end

  private def check_if_restricted_by_email
    if email == "admin@depot.com"
      raise Error.new "Cant delete or update this user"
    end
  end

  def admin?
    role == 'admin'
  end

  def should_force_logout?
    Time.now - last_activity_at >= 5.minutes
  end

  def update_last_activity
    update(last_activity_at: Time.now)
  end
end

class Error < StandardError
end
