# frozen_string_literal: true

require 'rails_helper'
require_relative '../../app/models/roll'

RSpec.describe Roll, type: :model do
  context 'evaluate' do
    let(:game) { Game.create }
    let(:frame) { Frame.create(game_id: game.id) }
    let(:frame1) { Frame.create(game_id: game.id) }

    it 'invokes evaluate_roll_value upon creation' do
      roll = Roll.new(value: 'X', frame_id: frame.id)
      expect(roll).to receive(:evaluate_roll_value).and_call_original
      roll.save
      expect(roll.numeric_value).to eq(10)
    end

    it 'has correct numeric_value and pending values when its a strike' do
      roll = Roll.new(value: 'X', frame_id: frame.id)
      roll.save
      expect(roll.numeric_value).to eq(10)
      expect(roll.pending1).to be(true)
      expect(roll.pending2).to be(true)
    end

    it 'has correct numeric_value and pending values when its a spare' do
      roll1 = Roll.new(value: '8', frame_id: frame.id)
      roll1.save
      roll2 = Roll.new(value: '/', frame_id: frame.id)
      roll2.save
      expect(roll2.numeric_value).to eq(2)
      expect(roll2.pending1).to be(true)
      expect(roll2.pending2).to be(false)
    end
    it 'has correct numeric_value when its a blank' do
      roll = Roll.new(value: '-', frame_id: frame.id)
      roll.save
      expect(roll.numeric_value).to eq(0)
      expect(roll.pending1).to be(false)
    end
    it 'has correct numeric_value when its a numerical value' do
      roll = Roll.new(value: '8', frame_id: frame.id)
      roll.save
      expect(roll.numeric_value).to eq(8)
      expect(roll.pending1).to be(false)
    end
    it 'has the correct total and pending1 values after update_pending1' do
      roll1 = Roll.new(value: '8', frame_id: frame.id)
      roll1.save
      roll2 = Roll.new(value: '/', frame_id: frame.id)
      roll2.save
      expect(roll2.total).to eq(2)
      expect(roll2.pending1).to be(true)
      roll2.update_pending1(9)
      expect(roll2.total).to eq(11)
      expect(roll2.pending1).to be(false)
    end

    it 'has the correct total and pending1 and pending2 values after update_pending1 and update_pending2' do
      roll = Roll.new(value: 'X', frame_id: frame.id)
      roll.save
      expect(roll.total).to eq(10)
      roll.update_pending1(9)
      expect(roll.pending1).to be(false)
      roll.update_pending2(1)
      expect(roll.total).to eq(20)
      expect(roll.pending1).to be(false)
    end
  end
end
