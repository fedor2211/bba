class EventsController < ApplicationController
  before_action :set_event, only: %i[show]
  before_action :authenticate_user!, except: %i[show index]
  before_action :set_current_user, only: %i[edit update destroy]
  helper_method :current_user_can_edit?

  def index
    @events = Event.all
  end

  def show
  end

  def new
    @event = current_user.events.build
  end

  def edit
  end

  def create
    @event = current_user.events.build(event_params)

    if @event.save
      redirect_to @event, notice: I18n.t("controllers.events.created")
    else
      render :new
    end
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: I18n.t("controllers.events.updated")
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to root_path, notice: I18n.t("controllers.events.destroy.success")
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :address, :datetime, :description)
  end

  def set_current_user
    @event = current_user.events.find(params[:id])
  end

  def current_user_can_edit?(event)
    user_signed_in? && event.user == current_user
  end
end
