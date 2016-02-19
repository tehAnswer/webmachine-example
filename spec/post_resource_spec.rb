RSpec.describe PostResource do
  include Webmachine::Test

  let(:app) { App }
  context 'GET /posts/:id' do
    it 'performs a successful request' do
      post '/posts/create', body: Oj.dump(text: 'fuck'), headers: { 'Content-Type' => 'application/json' }
      post_id = Oj.load(response.body)['response']['id']
      get "/posts/#{post_id}", { 'Accept' => 'application/msgpack' }
      expect(response.code).to eq(200)
    end
  end
end