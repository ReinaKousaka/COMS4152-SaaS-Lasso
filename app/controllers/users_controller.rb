class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create

    if user_params[:password] == "" or user_params[:email] == "" or user_params[:organizer_name] == ""
      flash[:error] = "Account information fields cannot be empty."
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

  private

  def user_params
    params.require(:user).permit(:email, :organizer_name, :password)
  end
end
