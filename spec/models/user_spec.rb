require 'spec_helper'

describe User do
  it { should have_many :clips }
  it { should have_and_belong_to_many :groups }

  describe "after_save" do
    let!(:user) { FactoryGirl.build :user, name: 'test-user' }
    let!(:response_body) do <<EOF
[
  {
    "login": "test-group",
    "id": 1234567
  }
]
EOF
    end

    before do
      stub_request(:get, "https://api.github.com/users/#{user.name}/orgs").
        to_return(
           body: response_body,
           status: 200,
           headers: { 'Content-Length' => response_body.size })
    end

    it 'creates groups user belongs' do
      user.save!
      expect(user.groups.pluck(:name)).to eq ["test-group"]
    end
  end

  describe ".from_omniauth" do
    subject { described_class.from_omniauth(auth) }

    let!(:provider) { 'github' }
    let!(:uid)      { '12345678' }
    let!(:name)     { 'testuser' }
    let!(:auth) do
      {
        'provider' => 'github',
        'uid' => uid,
        'info' => {
          'nickname' => name
        }
      }
    end
    let!(:user) { FactoryGirl.create :user, provider: provider, uid: uid, name: name}

    before do
      described_class.stub(:where).and_return([user])
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
      let!(:user) { nil }

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
