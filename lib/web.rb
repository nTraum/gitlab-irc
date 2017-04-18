require_relative 'message_formatter'
require 'fileutils'
require 'redis'
require 'sinatra'
require 'yaml'

config = YAML.load_file(File.join('config', 'config.yml'))

set :port, config['web']['port']
set :bind, config['web']['bind']

post '/commit' do
    
   # redis = Redis.new(:host => config['redis']['host'], :port => config['redis']['port'])
   # /var/run/redis/redis.sock
   redis = Redis.new(:path => "/var/run/redis/redis.sock")
  
   # if request.body.read != request_before
   messages = MessageFormatter.messages(request.body.read)
   messages.each { |msg| 

        msg_file = "/home/git/gitlab-irc/tmp/msg.txt"
        # MAKE SURE FILE FOR LAST MESSAGE EXISTS
        if !File.file?(msg_file)
            File.new(msg_file, "w")
        end

        contents = File.read(msg_file)

        if contents.to_s != msg.to_s
            redis.rpush("#{config['redis']['namespace']}:messages", msg)
        else
            # WHEN MESSAGE IS SAME AS BEFORE, DO NOT SEND IT TO IRC
            # DO NOTHING!
        end
        
        # REMEMBER LAST COMMIT MESSAGE
        File.truncate(msg_file, 0)
        File.write(msg_file, "#{msg}")
    } 
   
   redis.quit
end