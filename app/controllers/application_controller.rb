class ApplicationController < ActionController::Base
  
  include Devise::Controllers::Helpers
  # Devise関連の設定が先に処理されるように変更
  before_action :authenticate_user!, unless: :devise_controller? 

  def authenticate_admin!
    redirect_to root_path, alert: "管理者権限が必要です。" unless current_user&.admin?
  end

#  def after_sign_in_path_for(resource)
#     new_user_input_path # スマホ代入力画面へのパス
#   end

#   def logged_in?
#     !current_user.nil?
#   end

  # def current_user
  #   @current_user ||= User.find_by(id: session[:user_id])
  # end

  # def log_in(user)
  #   session[:user_id] = user.id
  # end

  # def log_out
  #   session.delete(:user_id)
  #   @current_user = nil
  # end

  def test_500
    raise "Intentional 500 Error"
  end
end