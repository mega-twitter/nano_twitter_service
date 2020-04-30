#nano twitter
require 'sinatra'
require 'sinatra/activerecord'
require 'json'
require_relative './models/tweet'
require_relative './models/user'

get '/search_tweet' do 
  @key_word = params[:search].downcase
  sql = "SELECT user_id, content, created_at FROM tweets, plainto_tsquery('#{@key_word}') AS q WHERE (tsv_tweet @@ q) 
  ORDER BY tweets.created_at DESC"
  @result_tweet = ActiveRecord::Base.connection.execute(sql)
  status 200
  @result_tweet.to_json
end

get '/search_user' do 
  @key_word = params[:search].downcase
  sql = "SELECT id, name FROM users where lower(name) LIKE '%#{@key_word}%'"
  @result_user = ActiveRecord::Base.connection.execute(sql)
  status 200
  @result_user.to_json
end