class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :password, presence: true

  def admin?
    self.role == 'admin'
  end
end
