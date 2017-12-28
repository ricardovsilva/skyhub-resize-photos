require 'mongo'

class MongoCacheService
  def initialize(mongo_url:, database_name:, expiration_seconds:)
    @client = Mongo::Client.new([mongo_url], database: database_name)
    @expiration_seconds = expiration_seconds ||= 3600
  end

  def get(collection_name)
    collection = @client[collection_name]
    response = collection.find.first
    response[:data] unless response.nil?
  end

  def add(object, collection_name)
    @client[collection_name].indexes.create_one({created_at: 1}, {expire_after: @expiration_seconds})
    @client[collection_name].insert_one({ data: object, created_at: DateTime.now })
  end
end