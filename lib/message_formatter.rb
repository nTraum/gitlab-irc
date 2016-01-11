require 'multi_json'
require 'googl'

class MessageFormatter
  def self.messages(json)
    msgs = []
    info = MultiJson.load(json)


    if info['object_kind'] == 'push'
        branch = info['ref'].split('/').last
        info['commits'].each do |ci|
            url = ci['url']
            ci_title = ci['message'].lines.first.chomp
            msg = "[#{info['object_kind']} -----#{info['repository']['name'].capitalize}(#{branch})] #{ci['author']['name']} | #{ci_title} | #{url}"
            msgs << msg
        end
    elsif info['object_kind'] == 'tag_push'

        if info['before'] == '0000000000000000000000000000000000000000'
            new = "New tag"
        else
            new = "Tag updated"
        end
        
        msg = "[#{new}] #{info['ref']} by #{info['repository']['name']}"
        msgs << msg    

    elsif info['object_kind'] == 'issue'
            
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
          
    elsif info['object_kind'] == 'note'

        noteable = info['object_attributes']['object_attributes']
        new = "New note on #{noteable}"
        msg = "[#{new}] #{info['object_attributes']['note']} | #{info['object_attributes']['url']}"
        msgs << msg    

    end
        
    return msgs
  end


#   def self.short_url(url)
#     Googl.shorten(url).short_url
#   end

end
