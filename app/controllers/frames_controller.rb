# frozen_string_literal: true

class FramesController < ApplicationController
  def index
    render json: Frame.all
  end

  def show
    render json: Frame.find(params[:id])
  end

  def new
    @game = Game.last
    @frames = @game.frames
    render :new
  end

  def create
    @game = Game.last
    @frame = Frame.create(game_id: @game.id)
    is_last = (@game.frames.length == 10)
    roll = Roll.create(value: frame_params[:roll1], frame_id: @frame.id, is_last:)
    

    Roll.create(value: frame_params[:roll2], frame_id: @frame.id, is_last:) if frame_params[:roll2].present?
    if frame_params[:roll3].present? && is_last
      Roll.create(value: frame_params[:roll3], frame_id: @frame.id, is_last: true)
    end
    if @game.frames.length >= 10
      redirect_to game_path @game.id
    else
      redirect_to new_frame_path
    end
  end

  private

  def frame_params
    params.require(:frame).permit(:roll1, :roll2, :roll3)
  end
end
