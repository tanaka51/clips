class SessionsController < ApplicationController
  skip_before_filter :authenticate_user, only: %w[create]
  skip_before_filter :filter_group

  def create
    user = User.from_omniauth(env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to clips_path(group_name: user.groups.first.name), notice: "Signed in."
  end

  def destory
    session[:user_id] = nil
    redirect_to root_url, notice: "Signed out."
  end
end
