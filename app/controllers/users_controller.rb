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
    id = params[:id] #retrieve user ID from URI route 
    @user = User.find params[:id] #look up event by unique ID
    @events = Event.where(:user_id => id.to_i).order(:start_time)
    @future_events = @events.where('start_time > ?', DateTime.now)

    @show_edit_profile = "display:none"

    if is_user_account(@user)
      @show_edit_profile = ""
    end 
    

    @past_events = Event.where(:user_id => id.to_i).where('start_time <= ?', DateTime.now).order(:title)

  end 

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
    @user.update_attributes!(user_params)
    flash[:notice] = "User Profile '#{@user.organizer_name}' was successfully updated."
    redirect_to events_path #"/users/", id: params[:id]
  end

  private

  def user_params
    params.require(:user).permit(:email, :organizer_name, :password,:description)
  end

  def is_user_account(user)
    if (current_user) and (session[:user_id] == user.id)
      return true
    else
      return false
    end
  end

end
