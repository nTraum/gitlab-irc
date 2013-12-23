require 'message_formatter'
require 'redis'
require 'sinatra'
require 'yaml'

config = YAML.load_file(File.join('config', 'config.yml'))

set :port, config['web']['port']
set :bind, config['web']['bind']

post '/commit' do
  redis = Redis.new(:host => config['redis']['host'], :port => config['redis']['port'])
  messages = MessageFormatter.messages(request.body.read)
  messages.each { |msg| redis.rpush("#{config['redis']['namespace']}:messages", msg) }
  redis.quit
end