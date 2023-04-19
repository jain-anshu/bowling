class GamesController < ApplicationController
  def new
    @game = Game.last 
    render 'new'
  end 

  def show
    @game = Game.find(params[:id])
    @game.calculate_total()
    render 'show'
  end

  def create
    @game = Game.create()
    @frame = Frame.create(game_id: @game.id)
    roll1 = Roll.create(value: game_params[:roll1], frame_id: @frame.id)
    roll2 = Roll.create(value: game_params[:roll2], frame_id: @frame.id) if game_params[:roll2].present?
    redirect_to new_frame_path
  end

  private
  def game_params
    params.require(:game).permit(:roll1, :roll2)
  end
end