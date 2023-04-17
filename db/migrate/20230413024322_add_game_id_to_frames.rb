class AddGameIdToFrames < ActiveRecord::Migration[7.0]
  def change
    add_column :frames, :game_id, :integer, foreign_key: true, index: true
  end
end
