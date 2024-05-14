class Participant < ApplicationRecord
  validates :name, presence: true

  has_many :consumptions

  before_validation on: :create do
    self.uid = SecureRandom.uuid if self.uid.blank?
  end

  attribute :consumptions_count
  def self.by_consumptions_desc
    self.all
      .left_joins(:consumptions)
      .select(
        self.arel_table[Arel.star],
        Consumption.arel_table[:count].sum.as('consumptions_count')
      )
      .group(:id)
      .order(consumptions_count: :desc)
  end

  
end
