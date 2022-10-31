class EventsController < ApplicationController
  before_action :force_index_redirect, only: [:index]
  
  def show 
    id = params[:id] #retrieve event ID from URI route 
    @event = Event.find(id) #look up event by unique ID 
    # will render app/views/event/show.<extension> by default
  end

  def index
    @all_categories = Event.all_categories
    @events = Event.with_categories(categories_list, sort_by)
    @categories_to_show_hash = categories_hash
    @sort_by = sort_by
    # remember the correct settings for next time
    session['categories'] = categories_list
    session['sort_by'] = @sort_by
  end 

  def new 
    #default: render 'new' template
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

  # private
  # # Making "internal" methods private is not required, but is a common practice.
  # # This helps make clear which methods respond to requests, and which ones do not.
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

  def force_index_redirect
    if !params.key?(:categories) || !params.key?(:sort_by)
      flash.keep
      url = events_path(sort_by: sort_by, categories: categories_hash)
      redirect_to url
    end
  end

end