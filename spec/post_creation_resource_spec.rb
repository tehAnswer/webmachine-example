RSpec.describe PostCreationResource do
  include Webmachine::Test

  let(:app) { App }
  context 'POST /posts/create' do
    it 'performs a successful request' do
      post '/posts/create', body: Oj.dump(text: 'fuck'), headers: { 'Content-Type' => 'application/json' }
      expect(response.code).to eq(201)
      expect(response.body).to include('fuck')
    end
  end
end