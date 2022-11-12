class EventsController < ApplicationController
  
  def show 
    id = params[:id] #retrieve event ID from URI route 
    @event = Event.find(id) #look up event by unique ID 
  end

  def index
    @all_categories = Event.all_categories
    @events = Event.with_categories(categories_list, sort_by)
    @categories_to_show_hash = categories_hash
    @sort_by = sort_by
    session['categories'] = categories_list
    session['sort_by'] = @sort_by

    start_date = params.fetch(:start_date, Date.today).to_date
    @meetings = @events.where(start_time: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week)
  end 

  def new 
  end

  def edit
    @event = Event.find params[:id]
  end

  def update
    @event = Event.find params[:id]
    @event.update_attributes!(event_params)
    flash[:notice] = "Event '#{@event.title}' was successfully updated."
    redirect_to events_path(@event)
  end

  def create 
    @event = Event.create!(event_params)
    flash[:notice] = "Event '#{@event.title}' was successfully created."
    redirect_to events_path
  end 

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    flash[:notice] = "Event '#{@event.title}' deleted."
    redirect_to events_path
  end

  def event_params
    params.require(:event).permit(:title, :category, :location, :organizer, :start_time, :end_time) 
  end

  def categories_list
    params[:categories]&.keys || session[:categories] || Event.all_categories
  end

  def categories_hash
    Hash[categories_list.collect { |item| [item, "1"] }]
  end

  def sort_by
    params[:sort_by] || session[:sort_by] || 'id'
  end

end