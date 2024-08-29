module Users
class SessionsController < ApplicationController
  # skip_before_action :login_required, only: [:new, :create]
  before_action :require_logout, only: [:new, :create]
  before_action :authenticate_user!, only: [:destroy]

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      flash[:success] = "ログインしました"
      redirect_to tasks_path
	  else
      flash[:danger] = 'メールアドレスまたはパスワードに誤りがあります'
      render :new
	  end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = "ログアウトしました"
    redirect_to new_user_session_path
  end    

  def guest_login
   user = User.find_or_create_by(email: 'guest@example.com') do |u|
     u.password = SecureRandom.hex
   end
   sign_in user
   redirect_to root_path, notice: 'ゲストユーザーとしてログインしました'

  end


  private

  def log_in(user)
    session[:user_id] = user.id
  end  

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end 

  def require_logout
    if current_user
    flash[:danger] = "ログアウトしてください"
    redirect_to tasks_path 
    end
  end
end
end