RSpec.describe PostResource do
  include Webmachine::Test

  let(:app) { App }
  context 'GET /posts/:id' do
    let(:headers) do
      {
        'Content-Type' => 'application/json'
      }
    end

    let(:body) do
      Oj.dump(text: 'fuck')
    end

    it 'performs a successful request' do
      post '/posts/create', body: body, headers: headers
      post_id = Oj.load(response.body)['response']['id']
      get "/posts/#{post_id}", 'Accept' => 'application/msgpack'
      expect(response.code).to eq(200)
    end
  end
end
