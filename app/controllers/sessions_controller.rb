class SessionsController < ApplicationController
  skip_before_filter :authenticate_user, only: %w[create]

  def create
    user = User.from_omniauth(env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to root_path, notice: "Signed in."
  end

  def destory
    session[:user_id] = nil
    redirect_to root_url, notice: "Signed out."
  end
end
