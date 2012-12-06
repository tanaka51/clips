# -*- coding: utf-8 -*-
require 'spec_helper'

describe ClipsController do
  let(:user) { FactoryGirl.create :user }

  before do
    stub_signin(user)
  end

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
    let!(:clip)   { FactoryGirl.create :clip, id: 1 }
    let!(:params) do
      { 'clip' => { 'code' => 'hogehoge' } }
    end

    let(:successed) { true }

    before do
      Clip.stub(:new)   { clip }
      clip.stub(:user=) { user }
      clip.stub(:save).and_return(successed)

      post 'create', params
    end

    it "creates a new Clip with current user" do
      expect(Clip).to have_received(:new).with('code' => 'hogehoge')
      expect(clip).to have_received(:user=).with(user)
      expect(clip).to have_received(:save)
    end

    context 'when successed to save' do
      it "redirects to 'show'" do
        expect(response).to redirect_to clip_path(clip)
      end

      it "sets a flash[:notice]" do
        expect(flash[:notice]).to_not be_nil
      end
    end

    context 'when failed to save' do
      let(:successed) { false }

      it "renders template 'new'" do
        expect(page).to render_template('new')
      end
    end
  end

  describe "GET 'show'" do
    # let の遅延評価だと FactoryGirl.create 時に stub されてしまうため、正格評価とする
    let!(:clip) { FactoryGirl.create :clip }

    before do
      Clip.stub(:find).and_return(clip)
      get 'show', id: clip.id
    end

    it "finds clip with id" do
      expect(Clip).to have_received(:find).with(clip.id.to_s)
    end

    it "assigns a given id's clip to @clip" do
      expect(assigns(:clip)).to eq(clip)
    end
  end

  describe "GET 'index'" do

    it "assigns a clips to @clips" do
      FactoryGirl.create_list :clip, 3, code: 'test'
      clips = Clip.all

      get 'index'

      expect(assigns(:clips)).to eq(clips)
    end
  end

  describe "GET 'edit'" do
    it "assigns a clip to @clip" do
      clip = FactoryGirl.create :clip, code: 'test'

      get 'edit', id: clip.id

      expect(assigns(:clip)).to eq clip
    end
  end

  describe "PUT 'update'" do
    let!(:clip) { FactoryGirl.create :clip, code: 'test' }
    let!(:code) { 'updated code' }
    let(:params) do {
        'id'   => clip.id,
        'clip' => { code: code }
      }
    end
    let(:successed) { true }

    before do
      Clip.stub(:find).and_return(clip)
      clip.stub(:update_attributes).and_return(successed)

      put 'update', params
    end

    it "assigns a clip to @clip" do
      expect(assigns(:clip)).to eq clip
    end

    it "updates a clip" do
      expect(clip).to have_received(:update_attributes).with('code' => code)
    end

    context "when successes to update" do
      let(:successed) { true }

      it "redirects to 'show'" do
        expect(response).to redirect_to clip_path(clip)
      end

      it "sets a flash[:notice]" do
        expect(flash[:notice]).to_not be_nil
      end
    end

    context "when failes to udpate" do
      let(:successed) { false }

      it "render template 'edit'" do
        expect(page).to render_template('edit')
      end
    end
  end
end
