require 'spec_helper'

describe 'routing to root' do
  it "routes / to clips#new" do
    expect(get: '/').to route_to(controller: 'clips', action: 'new')
  end
end
