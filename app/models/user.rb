class User < ApplicationRecord
  after_destroy :ensure_an_admin_remains
  validates :name, presence: true, uniqueness: true
  validates :email, uniqueness: true, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}
  has_secure_password

  private
    def ensure_an_admin_remains
      if User.count.zero?
        raise Error.new "Cant delete last user"
      end
    end
end

class Error < StandardError
end
