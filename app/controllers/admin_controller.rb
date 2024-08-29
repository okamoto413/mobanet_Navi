class AdminController < ApplicationController
  before_action :authenticate_admin!

  def dashboard
    # 管理者用ダッシュボードのロジック
  end
end