class RoomsController < ApplicationController
  before_action :set_room, only: [:edit, :update, :destroy]
  before_action :require_authentication, only: [:new, :create, :edit, :update, :destroy]

  PER_PAGE = 10

  def index
    @search_query = params[:q]

    rooms = Room.search(@search_query).page(params[:page]).per(PER_PAGE)

    @rooms = RoomCollectionPresenter.new(rooms.most_recent, self)
  end

  def show
    room_model = Room.friendly.find(params[:id])
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
      @room = current_user.rooms.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_params
      params.require(:room).permit(:title, :location, :description, :picture)
    end
end
