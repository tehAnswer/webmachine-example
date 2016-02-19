class PostResource < AbstractResource
  def allowed_methods
    ['GET']
  end

  def subject
    connection.posts.find(request.path_info[:id]).first
  end
end
