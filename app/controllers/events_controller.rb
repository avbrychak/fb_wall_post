class EventsController < ApplicationController

  def index
    @event = Event.new
  end

  def create
    current_user.create_event(event_params)
  end

  private

  def event_params
    params.require(:event).permit(:runner_id)
  end

end