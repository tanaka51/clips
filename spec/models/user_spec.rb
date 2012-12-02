require 'spec_helper'

describe User do
  describe ".from_omniauth" do
    subject { described_class.from_omniauth(auth) }

    let!(:provider) { 'github' }
    let!(:uid)      { '12345678' }
    let!(:name)     { 'testuser' }

    let(:auth) do
      {
        'provider' => 'github',
        'uid' => uid,
        'info' => {
          'nickname' => name
        }
      }
    end
    let(:user) { FactoryGirl.create :user, provider: provider, uid: uid, name: name}

    before do
      described_class
        .stub(:where)
        .with('provider' => provider, 'uid' => uid)
        .and_return([user])
    end

    it 'finds user from auth' do
      described_class.from_omniauth(auth)
      expect(described_class).to have_received(:where).with('provider' => provider, 'uid' => uid)
    end

    context "when user existes" do
      it 'returns a user' do
        expect(subject).to eq user
      end
    end

    context "when user dosen't exist" do
      before do
        described_class.stub(:where).and_return([])
      end

      it 'creates a user' do
        described_class.should_receive(:create!)
        described_class.from_omniauth(auth)
      end

      it 'returns user sames with auth' do
        user = subject

        expect(user.provider).to eq provider
        expect(user.uid)     .to eq uid
        expect(user.name)    .to eq name
      end
    end
  end

end
