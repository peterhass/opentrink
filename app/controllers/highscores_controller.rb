class HighscoresController < ApplicationController
  def show 
    @participants = Participant.by_consumptions_desc.limit(10).reject { |p| p.consumptions_count.nil? }
  end
end
