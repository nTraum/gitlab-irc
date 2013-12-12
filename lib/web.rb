require 'sinatra'
require 'multi_json'
require 'yaml'
require 'googl'
require 'redis'

$config = YAML.load_file(File.join('config', 'config.yml'))

set :port, $config['web']['port']
set :bind, $config['web']['bind']

post '/commit' do
  redis = Redis.new(:host => $config['redis']['host'], :port => $config['redis']['port'])
  json = MultiJson.load request.body.read
  json['commits'].each do |commit|
        url = Googl.shorten(commit['url']).short_url
        commit_message = commit['message'].gsub(/\n/," ")
        irc_message = "[#{json['repository']['name'].capitalize}] #{commit['author']['name']} | #{commit_message} | #{url}"
        redis.rpush("#{$config['redis']['namespace']}:messages", irc_message)
        redis.quit
    end
end