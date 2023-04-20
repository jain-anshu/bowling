# frozen_string_literal: true

require 'rails_helper'
require_relative '../../app/models/game'

RSpec.describe Game, type: :model do
  context 'evaluate' do
    let!(:game) { Game.create }
    let!(:frame1) { Frame.create(game_id: game.id) }
    let!(:roll1) { Roll.create(value: 'X', frame_id: frame1.id)}
    let!(:frame2) { Frame.create(game_id: game.id) }
    let! (:roll2) { Roll.create(value: '8', frame_id: frame2.id)}
    let! (:roll3) { Roll.create(value: '1', frame_id: frame2.id)}
    let!(:frame3) { Frame.create(game_id: game.id) }
    let! (:roll4) { Roll.create(value: '7', frame_id: frame2.id)}

    it 'updates rolls with correct totals and pendings upon creation' do
       game.calculate_total
       expect(game.final_score).to eq(35)
    end
  end

end