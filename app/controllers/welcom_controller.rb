class WelcomController < ApplicationController
  skip_before_filter :authenticate_user, :filter_group

  def index
    return unless current_user
    redirect_to clips_path(group_name: current_user.groups.first.name)
  end
end
