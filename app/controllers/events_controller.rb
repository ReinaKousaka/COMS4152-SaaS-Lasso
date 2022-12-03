class EventsController < ApplicationController
  before_action :require_login, only: [:update, :destroy, :create]

  def show 
    id = params[:id] #retrieve event ID from URI route 
    @event = Event.find params[:id] #look up event by unique ID 
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
    redirect_to events_path
  end

  def create
    # augment field user_id
    params_copy = event_params
    params_copy[:user_id] = session[:user_id]

    start_time = DateTime.new(event_params["start_time(1i)"].to_i, 
                        event_params["start_time(2i)"].to_i,
                        event_params["start_time(3i)"].to_i,
                        event_params["start_time(4i)"].to_i,
                        event_params["start_time(5i)"].to_i)

    end_time = DateTime.new(event_params["end_time(1i)"].to_i, 
                        event_params["end_time(2i)"].to_i,
                        event_params["end_time(3i)"].to_i,
                        event_params["end_time(4i)"].to_i,
                        event_params["end_time(5i)"].to_i)


    if start_time > end_time
         flash[:error] = "Event end time must be after event start time."
         # stay in the same page
         redirect_to :back
         return 
    end     
    
    @event = Event.create!(params_copy)
    flash[:notice] = "Event '#{@event.title}' was successfully created."
    redirect_to events_path
  end 

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    flash[:notice] = "Event '#{@event.title}' deleted."
    redirect_to events_path
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

  private

  def event_params
    params
      .require(:event)
      .permit(:title, :category, :location, :organizer, :start_time, :end_time, :user_id, :description)
      # .reverse_merge(user_id: session[:user_id])
  end


  def require_login()
    begin
      @event = Event.find params[:id]
      if @event.user_id != session[:user_id]
        flash[:error] = "You must be logged in to access this section"
        # stay in the same page
        redirect_to :back 
      end
    rescue Exception => e
      unless current_user
        flash[:error] = "You must be logged in to access this section"
        # stay in the same page
        redirect_to :back 
      end
    end
  end
end
