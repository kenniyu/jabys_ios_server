class RoomsController < ApplicationController
  before_filter :authenticate_user!

  # GET /products
  # GET /products.json
  def index
    @rooms = Room.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rooms }
    end
  end

  def create
    @room = Room.new(params[:room])
    params[:room][:creator_id] = current_user.id

    respond_to do |format|
      if @room.save
        Pusher['rooms_channel'].trigger('room_created', {
          name: @room.name
        })
        format.html { redirect_to @room, notice: 'Room created.' }
        format.json { render json: @room, status: :created, location: @room}
      else
        format.html { render action: "new" }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /rooms/new
  # GET /rooms/new.json
  def new
    @room = Room.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @room }
    end
  end

  # GET /rooms/1/edit
  def edit
    @room = Room.find(params[:id])
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
    @room = Room.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @room }
    end
  end

end
