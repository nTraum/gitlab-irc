require 'multi_json'
require 'net/http'
require 'xmlsimple'

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
            short = config['msg']['short_uri'] ? "#{short_url(url)}" : "#{url}"
            msg = "[#{info['repository']['name'].capitalize}(#{branch})] by #{ci['author']['name']} | #{ci_title} | #{short}"
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
            
        if info['object_attributes']['action'] == 'update'
            new = "Issue updated"
        else
            new = "Issue #{info['object_attributes']['state']}"
        end

        author = info['user']['username']
        title = info['object_attributes']['title']
        url = info['object_attributes']['url']
        short = config['msg']['short_uri'] ? "#{short_url(url)}" : "#{url}"
        msg = "[#{new}] by #{author} | #{title} | #{short}"
        msgs << msg
          
    elsif info['object_kind'] == 'note' && config['msg']['note'] == true

        noteable = info['object_attributes']['noteable_type']
        username = info['user']['username'] 
        url = info['object_attributes']['url']
        short = config['msg']['short_uri'] ? "#{short_url(url)}" : "#{url}"
        new = "New note on #{noteable}"
        msg = "[#{new}] by #{username} | #{short}"
        msgs << msg

    end
        
    return msgs
  end

  def self.short_url(url)

    url = URI.parse("http://bn.gy//API.asmx/CreateUrl?real_url=#{url}")
    req = Net::HTTP::Get.new(url.to_s)
    resp = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    data = XmlSimple.xml_in resp.body 
    shorty = "#{data["ShortenedUrl"]}"[2..-3]
    return shorty
    
  end

end
