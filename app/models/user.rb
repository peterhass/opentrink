class User < ApplicationRecord
  authenticates_with_sorcery!

  belongs_to :invitation

  validates :name, presence: true

  before_create :set_password

  delegate :bar?, to: :invitation
  delegate :admin?, to: :invitation

  scope :newest_first, -> { order(created_at: :desc) }

  def activated?
    !deactivated?
  end

  private

  def set_password
    self.password = SecureRandom.hex(300)
  end
end
