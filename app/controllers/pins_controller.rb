class PinsController < ApplicationController
  before_filter :set_pin, only: [:show, :edit, :update, :destroy]
  before_filter :correct_user, only: [:edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:index, :show]

  respond_to :html

  def index
    @pins = Pin.order("created_at DESC").paginate(:page => params[:page], :per_page => 5)
    respond_with(@pins)
  end

  def show
    respond_with(@pin)
  end

  def new
    @pin = current_user.pins.build
    respond_with(@pin)
  end

  def edit
  end

  def create
    @pin = current_user.pins.build(params[:pin])
    @pin.save
    respond_with(@pin)
  end

  def update
    @pin.update_attributes(params[:pin])
    respond_with(@pin)
  end

  def destroy
    @pin.destroy
    respond_with(@pin)
  end

 

  private
    def set_pin
      @pin = Pin.find(params[:id])
    end

    def correct_user
      @pin = current_user.pins.find_by_id(params[:id])
      redirect_to pins_path, notice: "Not authorized !" if @pin.nil?
    end
end
