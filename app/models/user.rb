class User < ApplicationRecord
  authenticates_with_sorcery!

  belongs_to :invitation

  validates :name, presence: true

  before_create :set_password

  private

  def set_password
    self.password = SecureRandom.hex(300)
  end
end
