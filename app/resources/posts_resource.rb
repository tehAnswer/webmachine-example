class PostsResource < AbstractResource
  def allowed_methods
    ['GET']
  end

  def subject
    connection.posts.all
  end

  def transform(object)
    object.to_a
  end
end