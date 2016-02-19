RSpec.describe PostsResource do
  include Webmachine::Test

  let(:app) { App }
  context 'GET /posts/' do
    it 'performs a successful request' do
      get '/posts', 'Accept' => 'application/msgpack'
      expect(response.code).to eq(200)
    end
  end
end
