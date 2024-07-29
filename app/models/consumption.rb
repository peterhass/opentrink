class Consumption < ApplicationRecord
  belongs_to :participant

  validate :validate_participant, on: :create

  private

  def validate_participant
    return if participant.activated?

    errors.add(:base, 'Deactivated participant cannot consume more')
  end
end
