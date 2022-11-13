class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: user_params[:email])
    if @user
      if @user.password == user_params[:password]
        # Sets a signed cookie, which prevents users from tampering with its value.
        # Sets an encrypted cookie value before sending it to the client which
        # See: https://api.rubyonrails.org/v5.1/classes/ActionDispatch/Cookies.html
        cookies.encrypted.signed[:user_id] = @user.id
        # redirect_to root_path
        put 'redirect!'
        redirect_to '/events'
      else
        flash[:notice] = 'Incorrect Password!'
      end
    else
      flash[:notice] = 'The Account Does Not Exist!'
    end
    render :new
  end

  def destroy
    session[:user_id] = nil
    redirect_to sign_in_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :password)
  end
end
