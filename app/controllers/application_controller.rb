# -*- coding: utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user, :filter_group

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authenticate_user
    redirect_to welcome_path unless current_user
  end

  def filter_group
    @group_name = params['group_name']

    # うまいことリファクタリングしたい
    if current_user
      unless current_user.groups.exists?(name: @group_name)
        render file: "#{Rails.root}/public/403", status: 403, layout: false
        return
      end
    end
  end

end
