class ParticipantScore < ApplicationRecord
  scope :total_ranked, -> { where.not(total_rank: nil).order(total_rank: :asc) }

  def participant
    self.becomes(Participant)
  end
end
