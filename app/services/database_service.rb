require 'sequel'

class DatabaseService < SimpleDelegator
  def initialize
    @connection = Sequel.sqlite
    @connection.create_table :posts do
      primmary_key :id
      String :text
      DateTime :created_at
    end
    __setobj__(@connection)
  end

  [:posts].each do |entity|
    define_method entity do
      @connection[entity]
    end
  end
end
