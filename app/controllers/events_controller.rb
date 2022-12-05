class EventsController < ApplicationController
  before_action :require_login, only: [:update, :destroy, :create]
  helper_method :is_event_belongs_to_user?, :show_edit_and_delete

  def show 
    id = params[:id] #retrieve event ID from URI route 
    # include user then look up event by unique ID 
    @event = Event.includes(:user).find params[:id]
  end

  def index
    @all_categories = Event.all_categories
    @events = Event.with_categories(categories_list, sort_by)
    @categories_to_show_hash = categories_hash
    @sort_by = sort_by
    @search_by = search_by
    session['categories'] = categories_list
    session['sort_by'] = @sort_by
    session['search_by'] = @search_by

    start_date = params.fetch(:start_date, Date.today).to_date
    @meetings = @events.where(start_time: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week)
    if session['user_id'] 
      @organizer = User.find(session[:user_id])
      @username = @organizer.organizer_name
      @sign_in_display = 'display:none'
      @sign_out_display = ''
    else 
      @username = 'you need to sign in!'
      @sign_in_display = ''
      @sign_out_display = 'display:none'
    end

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

  def search
      @search_param = params[:search_by].downcase
      @search_result = Event.all.where("lower(title) LIKE :search", search:"%#{@search_param}%")
  end


  private
  def event_params
    params
      .require(:event)
      .permit(:title, :category, :location, :start_time, :end_time, :user_id, :description)
      # .reverse_merge(user_id: session[:user_id])
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

  def search_by
    params[:search_by] || session[:search_by] || 'title'
  end

  def require_login
    begin
      @event = Event.find params[:id]
      if @event.user_id != session[:user_id]
        flash[:error] = "You are not the event organizer for this event."
        # stay in the same page
        redirect_to :back 
      end
    rescue Exception => e
      unless current_user
        flash[:error] = "You must be logged in to an event organizer account."
        # stay in the same page
        redirect_to :back 
      end
    end
  end

  def show_edit_and_delete(event)
    if is_event_belongs_to_user?(event)
      return '' 
    else 
      return 'display:none'
    end 
  end 

  def is_event_belongs_to_user?(event)
    if (current_user) and (session[:user_id] == event.user_id)
      return true
    else
      return false
    end
  end

end
