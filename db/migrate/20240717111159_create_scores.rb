class CreateScores < ActiveRecord::Migration[7.1]
  def change
    create_view :scores
  end
end
