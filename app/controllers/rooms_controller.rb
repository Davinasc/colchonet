class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]
  before_action :require_authentication, only: [:new, :create, :edit, :update, :destroy]

  def index
    @rooms = Room.all
  end

  def show
  end

  def new
    @room = Room.new
  end

  def edit
  end

  def create
    @room = Room.new(room_params)
      if @room.save
        redirect_to @room, notice: 'Room was successfully created.' 
      else
        render :new
      end
  end

  def update
      if @room.update(room_params)
        redirect_to @room, notice: 'Room was successfully updated.'
      else
        render :edit
      end
  end

  def destroy
    @room.destroy
    redirect_to rooms_url, notice: 'Room was successfully destroyed.' 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_params
      params.require(:room).permit(:title, :location, :description)
    end
end
