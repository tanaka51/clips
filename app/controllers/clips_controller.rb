class ClipsController < ApplicationController
  before_filter :prepare_clip, only: %w[show edit update]

  def new
    @clip = Clip.new
  end

  def create
    @clip = Clip.new(params['clip'])
    @clip.user = current_user

    if @clip.save
      redirect_to clip_path(group_name: @group_name, id: @clip.id), notice: 'clip was successfuly created'
    else
      render :new
    end
  end

  def show
  end

  def index
    @clips = Clip.all
  end

  def edit
  end

  def update
    if @clip.update_attributes(params['clip'])
      redirect_to clip_path(group_name: @group_name, id: @clip.id), notice: 'clip was successfuly updated'
    else
      render :edit
    end
  end

  private
  def prepare_clip
    @clip = Clip.find(params['id'])
  end

end
