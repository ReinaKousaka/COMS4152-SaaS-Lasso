class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: user_params[:email])
    if @user
      if @user.is_password?(user_params[:password])
        session[:user_id] = @user.id
        redirect_to root_path
      else
        flash[:notice] = 'Incorrect Password!'
        render :new
      end
    else
      flash[:notice] = 'The Account Does Not Exist!'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :password)
  end
end
