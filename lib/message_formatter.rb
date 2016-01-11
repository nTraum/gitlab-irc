require 'multi_json'
require 'googl'

class MessageFormatter
  def self.messages(json)

    config = YAML.load_file(File.join('config', 'config.yml'))

    msgs = []
    info = MultiJson.load(json)

    if info['object_kind'] == 'push' && config['msg']['push'] == true
        branch = info['ref'].split('/').last
        info['commits'].each do |ci|
            url = ci['url']
            ci_title = ci['message'].lines.first.chomp
            msg = "[#{info['repository']['name'].capitalize}(#{branch})] #{ci['author']['name']} | #{ci_title} | #{url}"
            msgs << msg
        end
    elsif info['object_kind'] == 'tag_push' && config['msg']['tag_push'] == true

        if info['before'] == '0000000000000000000000000000000000000000'
            new = "New tag"
        else
            new = "Tag updated"
        end
        
        msg = "[#{new}] #{info['ref']} by #{info['repository']['name']}"
        msgs << msg    

    elsif info['object_kind'] == 'issue' && config['msg']['issue'] == true
            
        if info['object_attributes']['created_at'] == info['object_attributes']['updated_at']
            new = "New issue"
        else
            new = "Issue updated"
        end
        
        author = info['user']['username']
        title = info['object_attributes']['title']
        url = info['object_attributes']['url']
        msg = "[#{new}] by #{author} | #{title} | #{url}"
        msgs << msg
          
    elsif info['object_kind'] == 'note' && config['msg']['note'] == true

        noteable = info['object_attributes']['noteable_type']
        username = info['user']['username'] 
        new = "New note on #{noteable} by #{username}"
        msg = "[#{new}] #{info['object_attributes']['url']}"
        msgs << msg    

    end
        
    return msgs
  end


#   def self.short_url(url)
#     Googl.shorten(url).short_url
#   end

end
