require 'rspec/core/shared_context'

module StubHttpRequest
  extend RSpec::Core::SharedContext

  before do
    stub_request(:any, /.*api\.github\.com.*/).
      to_return(:status => 200, :body => "", :headers => {})
  end
end
