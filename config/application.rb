require 'webmachine'
require 'msgpack'
require 'oj'
require 'pry'

require_relative '../app/services/database_service'
require_relative '../app/resources/abstract_resource'
require_relative '../app/resources/posts_resource'
require_relative '../app/resources/post_creation_resource'
require_relative '../app/resources/post_resource'

DB = DatabaseService.new

App = Webmachine::Application.new do |app|
  app.configure do |config|
    config.port = 5656
    config.adapter = :WEBrick
  end

  app.routes do
    add ['posts'], PostsResource
    add ['posts', 'create'], PostCreationResource
    add ['posts', :id], PostResource
  end

  app.define_singleton_method(:connection) do
    DB
  end
end

# App.run