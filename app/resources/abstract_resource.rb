class AbstractResource < Webmachine::Resource
  attr_reader :subject

  def connection
    App.connection
  end

  def content_types_provided
    [
      ['application/json', :to_json],
      ['application/msgpack', :to_msgpack]
    ]
  end

  def to_json
    Oj.dump({ response: transform(subject) }, mode: :compat)
  end

  def to_msgpack
    transform(subject).to_msgpack
  end

  def transform(hash)
    hash[:created_at] = hash[:created_at].to_s
    hash
  end
end
