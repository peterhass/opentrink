class Invitation < ApplicationRecord
  belongs_to :created_by, class_name: 'User', optional: true
  has_many :users

  before_create :set_id

  scope :newest_first, -> { order(created_at: :desc) }
  scope :activated, -> { where(deactivated: false) }

  enum :role, { bar: 'bar', admin: 'admin' }

  def activated?
    !deactivated?
  end

  private

  def set_id
    self.id = SecureRandom.uuid if self.id.blank?
  end
end
