class Participant < ApplicationRecord
  validates :name, presence: true

  has_many :consumptions

  before_validation on: :create do
    self.uid = SecureRandom.uuid if self.uid.blank?
  end

  scope :newest_first, -> { order(created_at: :desc) }

  def emoji_id
    list = []
    remaining = id

    until remaining <= 0 do
      remaining, index = remaining.divmod(Opentrink::Emoji.alphabet.length)
      list.push(Opentrink::Emoji.alphabet[index])
    end

    list.join('')
  end
end
