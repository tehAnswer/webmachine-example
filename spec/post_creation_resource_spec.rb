RSpec.describe PostCreationResource do
  include Webmachine::Test

  let(:app) { App }
  context 'POST /posts/create' do
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
      expect(response.code).to eq(201)
      expect(response.body).to include('fuck')
    end
  end
end
