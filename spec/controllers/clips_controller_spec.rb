# -*- coding: utf-8 -*-
require 'spec_helper'

describe ClipsController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      expect(response).to be_success
    end

    it "assins a new clip to @clip" do
      clip = stub_model(Clip)
      Clip.should_receive(:new).and_return(clip)
      get 'new'

      expect(assigns(:clip)).to eq(clip)
    end
  end

  describe "POST 'create'" do
    it "creates a new Clip" do
      request_params = { 'clip' => { 'code' => 'hogehoge' } }

      clip = stub_model(Clip)
      Clip.should_receive(:new).with('code' => 'hogehoge').and_return(clip)
      clip.should_receive(:save)

      post 'create', request_params
    end

    context 'when successed to save' do
      let!(:clip) { FactoryGirl.create :clip, id: 1 }

      before do
        Clip.stub(:new) { clip }
      end

      it "redirects to 'show'" do
        post 'create'
        expect(response).to redirect_to clip_path(id: clip.access_id)
      end

      it "sets a flash[:notice]" do
        post 'create'
        expect(flash[:notice]).to_not be_nil
      end
    end

    context 'when failed to save' do
      it "renders template 'new'" do
        clip = stub_model(Clip)
        Clip.stub(:new) { clip }
        clip.stub(:save) { false }

        post 'create'
        expect(page).to render_template('new')
      end
    end

  end

  describe "GET 'show'" do
    # let の遅延評価だと FactoryGirl.create 時に stub されてしまうため、正格評価とする
    let!(:clip) { FactoryGirl.create :clip }

    it "finds clip with access_id" do
      Clip.should_receive(:where).with(access_id: clip.access_id).and_return([clip])

      get 'show', id: clip.access_id
    end

    it "assigns a given id's clip to @clip" do
      Clip.stub(:where).and_return([clip])

      get 'show', id: clip.access_id

      expect(assigns(:clip)).to eq(clip)
    end
  end

end
