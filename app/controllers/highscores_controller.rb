class HighscoresController < ApplicationController
  def show 
    @participants = Participant.by_consumptions_desc.limit(10)
  end
end
