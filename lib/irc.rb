require 'cinch'
require 'yaml'
require 'redis'

$config = YAML.load_file(File.join('config', 'config.yml'))

class PollingPlugin
  include Cinch::Plugin

  timer $config['irc']['poll_interval'], :method => :timed

  def timed
    redis = Redis.new(:host => $config['redis']['host'], :port => $config['redis']['port'])
    key = "#{$config['redis']['namespace']}:messages"
    while redis.llen(key) > 0
      Channel($config['irc']['channel']).send(redis.lpop(key))
    end
    redis.quit
  end
end

bot = Cinch::Bot.new do
  configure do |c|
    c.server = $config['irc']['server']
    c.port = $config['irc']['port']
    if $config['irc']['channel_password']
      c.channels = [$config['irc']['channel'] + " " + $config['irc']['channel_password']]
    else
      c.channels = [$config['irc']['channel']]
    end
    c.nick = $config['irc']['nickname']
    c.realname = $config['irc']['nickname']
    c.messages_per_second = 1
    c.user = $config['irc']['nickname']
    c.plugins.plugins = [PollingPlugin]
    c.verbose = $config['irc']['verbose']
  end
end

bot.start
