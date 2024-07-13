class ParticipantDisplayName < ViewComponent::Base
  erb_template <<~ERB
    <span class="inline-flex item-baseline rounded-md bg-purple-50 px-2 py-1 text-md font-medium text-purple-800 ring-1 ring-inset ring-gray-500/10">
      <%= participant.name %> <%= participant.emoji_id %>
    </span>
  ERB

  def initialize(participant)
    @participant = participant
    super
  end

  private

  attr_reader :participant
end
