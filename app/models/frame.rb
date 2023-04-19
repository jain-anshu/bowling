# frozen_string_literal: true

class Frame < ApplicationRecord
  has_many :rolls
  belongs_to :game
end
