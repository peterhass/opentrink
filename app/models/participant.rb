class Participant < ApplicationRecord
  validates :name, presence: true

  has_many :consumptions

  before_validation on: :create do
    self.uid = SecureRandom.uuid if self.uid.blank?
  end
end
