class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  after_destroy :ensure_an_admin_remains

  class Error < StandardError
  end

  private

  def ensure_an_admin_remains
    if User.count.zero?
      raise Error, "Can't delete last user"
    end
  end
end
