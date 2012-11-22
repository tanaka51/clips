class ClipsController < ApplicationController
  def new
    @clip = Clip.new
  end

  def create
    @clip = Clip.new(params['clip'])

    if @clip.save
      redirect_to clip_path(@clip), notice: 'clip was successfuly created'
    else
      render :new
    end
  end

  def show
    @clip = Clip.find(params['id'])
  end
end
