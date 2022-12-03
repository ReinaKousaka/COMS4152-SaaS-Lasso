class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if user_params[:email] == "" or user_params[:organizer_name] == ""
      flash[:error] = "Account information fields cannot be empty."
      redirect_to :back
      return 
    end
    if user_params[:password].length <= 5
      flash[:error] = "Password is too short!"
      redirect_to :back
      return
    end

    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash[:notice] = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  def show 
    id = params[:id] #retrieve event ID from URI route 
    @user = User.find params[:id] #look up event by unique ID
    @events = Event.where(:user_id => id.to_i).order(:start_time)
    @future_events = @events.where('start_time > ?', DateTime.now)

    @past_events = Event.where(:user_id => id.to_i).where('start_time <= ?', DateTime.now).order(:title)

  end 

  private

  def user_params
    params.require(:user).permit(:email, :organizer_name, :password)
  end
end
