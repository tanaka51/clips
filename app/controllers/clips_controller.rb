class ClipsController < ApplicationController
  before_filter :prepare_clip, only: %w[show edit update]

  def new
    @clip = Clip.new
  end

  def create
    @clip = Clip.new(params['clip'])

    if @clip.save
      redirect_to clip_path(id: @clip.access_id), notice: 'clip was successfuly created'
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
      redirect_to clip_path(id: @clip.access_id), notice: 'clip was successfuly updated'
    else
      render :edit
    end
  end

  private
  def prepare_clip
    @clip = Clip.where(access_id: params['id']).first
  end
end
