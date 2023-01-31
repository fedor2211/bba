class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[show index]
  after_action :verify_authorized, except: %i[index]
  after_action :verify_policy_scoped, only: %i[index]

  def index
    @events = policy_scope(Event)
  end

  def show
    authorize @event
    @new_comment = @event.comments.build(params[:comment])
    @new_subscription = @event.subscriptions.build(params[:subscription])
    @new_photo = @event.photos.build(params[:photo])
  end

  def new
    @event = current_user.events.build
    authorize @event
  end

  def edit
    authorize @event
  end

  def create
    @event = current_user.events.build(event_params)
    authorize @event

    if @event.save
      redirect_to @event, notice: I18n.t("controllers.events.created")
    else
      render :new
    end
  end

  def update
    authorize @event
    if @event.update(event_params)
      redirect_to @event, notice: I18n.t("controllers.events.updated")
    else
      render :edit
    end
  end

  def destroy
    authorize @event
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
end
