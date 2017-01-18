class RoomsController < ApplicationController
  before_action :set_room, only: [:edit, :update, :destroy]
  before_action :require_authentication, only: [:new, :create, :edit, :update, :destroy]

  def index
    @search_query = params[:q]
    rooms = Room.search(@search_query)

    @rooms = rooms.most_recent.map do |room|
      RoomPresenter.new(room, self, false)
    end
  end

  def show
    room_model = Room.find(params[:id])
    @room = RoomPresenter.new(room_model, self)
  end

  def new
    @room = current_user.rooms.build
  end

  def edit
  end

  def create
    @room = current_user.rooms.new(room_params)
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

    def set_room
      @room = current_user.rooms.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_params
      params.require(:room).permit(:title, :location, :description)
    end
end
