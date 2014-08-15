module Jekyll
  module EmbedFilter
    def video_url(url)
      if url.gsub(/^((.*?)\.)?youtube\.(.*?)\/watch(.*)$/, 'GOOD') == 'GOOD'
        url.gsub(/^((.*?)\.)?youtube\.(.*?)\/watch\?(.*?)?v=(.*?)(&.*)?$/) do |w|
          return "http://www.youtube.com/v/" + $5 + "?autoplay=0"
        end
      elsif url.gsub(/^((.*?)\.)?facebook\.(.*?)\/video\/video.php(.*)$/, 'GOOD') == 'GOOD'
        url.gsub(/^((.*?)\.)?facebook\.(.*?)\/video\/video.php\?(.*?)?v=(.*?)(&.*)?$/) do |w|
          return "http://www.facebook.com/v/" + $5
        end
      else
        return ''
      end
    end
  end
end

Liquid::Template.register_filter(Jekyll::EmbedFilter)
