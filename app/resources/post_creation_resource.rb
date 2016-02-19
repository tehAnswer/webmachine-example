class PostCreationResource < AbstractResource
  def allowed_methods
    ['POST']
  end

  def content_types_accepted
    [
      ['application/json', :from_json]
    ]
  end

  def malformed_request?
    parsed_json.keys != [:text]
  end

  def post_is_create?
    true
  end

  def parsed_json
    Oj.load(request.body.to_s, symbol_keys: true)
  end

  def create_path
    "/posts/#{next_id}"
  end

  def next_id
    @last_id ||= SecureRandom.hex
  end

  def from_json
    params = parsed_json.merge(meta_params)
    connection.posts.insert(params)
    @subject = transform_params(params)
    render_method = accept_header_provided? ? to_format : :to_json
    response.body = send(render_method)
    201
  end

  def meta_params
    { created_at: Time.now.utc, id: @last_id }
  end

  def transform_params(params)
    params[:created_at] = params[:created_at].to_s
    params[:path] = create_path
    params
  end

  def to_format
    "to_#{request.headers['Accept'].split('/')[1]}"
  end

  def accept_header_provided?
    request.headers['Accept'] != '*/*'
  end
end
