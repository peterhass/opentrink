class ParticipantDisplayName < ViewComponent::Base
  erb_template <<~ERB
    <span class="<%= classes %>">
      <span class="truncate"><%= participant.name %></span>
      <span><%= participant.emoji_id %></span>
    </span>
  ERB

  def initialize(participant)
    @participant = participant
    super
  end

  private

  attr_reader :participant

  def classes
    Opentrink::Clsx.call(%w[inline-grid
                            grid-cols-[1fr_auto]
                            item-baseline
                            gap-1
                            rounded-md
                            bg-purple-50
                            px-2
                            py-1
                            text-md
                            font-medium
                            text-purple-800
                            ring-1
                            ring-inset
                            ring-gray-500/10])
  end
end
