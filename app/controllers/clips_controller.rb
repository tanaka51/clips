class ClipsController < ApplicationController
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
    @clip = Clip.where(access_id: params['id']).first
  end

  def index
    @clips = Clip.all
  end
end
