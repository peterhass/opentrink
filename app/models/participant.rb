class Participant < ApplicationRecord
  validates :name, presence: true

  has_many :consumptions

  scope :newest_first, -> { order(created_at: :desc) }
  scope :search_by_name, ->(name) { where('name like ?', "%#{sanitize_sql_like(name)}%") }

  def activated?
    !deactivated?
  end

  def emoji_id
    list = []
    remaining = id

    until remaining <= 0
      remaining, index = remaining.divmod(Opentrink::Emoji.alphabet.length)
      list.push(Opentrink::Emoji.alphabet[index])
    end

    list.join('')
  end
end
