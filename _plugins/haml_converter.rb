module Jekyll
  require 'haml'
  require 'ostruct'
  require 'cgi'
  require 'pp'
  
  module HamlHelpers
    
    def h(text)
      CGI.escapeHTML(text)
    end
    
    def link_to(text, url, attributes = {})
      attributes = { :href => url }.merge(attributes)
      attributes = attributes.map {|key, value| %{#{key}="#{h value}"} }.join(" ")
      "<a #{attributes}>#{text}</a>"
    end
    
  end
  
  module Convertible
  
    alias old_render_liquid render_liquid
    
    def render_liquid(content, payload, info, path = nil)
      if path and File.extname(path) == '.haml'
          context = OpenStruct.new({
            :site => OpenStruct.new(payload["site"]),
            :page => OpenStruct.new(payload["page"])
          })
          context.extend(HamlHelpers)
          
          engine = Haml::Engine.new(content)
          content = engine.render(context)
      end
      
      old_render_liquid(content, payload, info, path)
    end
  
  end
  
#  class Converter
#  
#    def locals(locals = nil)
#        @locals = locals if locals
#        @locals
#    end
#  
#  end
#  
#  class Site
#    
#    def expose_data
#      #pp self.converters
#      self.converters.map do |c|
#        c.locals({:site => self})
#      end
#    end
#    
#  end
#
#  class Layout
#
#    alias old_initialize initialize
#
#    def initialize(site, base, name)
#      old_initialize(site, base, name)
#      
#      site.expose_data
#      
#      self.transform
#    end
#
#  end
#  
#  class HamlConverter < Converter
#    safe true
#    priority :low
#
#    def matches(ext)
#      ext =~ /haml/i
#    end
#
#    def output_ext(ext)
#      ".html"
#    end
#
#    def convert(content)
#      engine = Haml::Engine.new(content)
#      engine.render(Object.new, :site => OpenStruct.new(@locals[:site].site_payload['site']))
#    end
#  end

  require 'sass'
  class SassConverter < Converter
    safe true
    priority :low

     def matches(ext)
      ext =~ /sass/i
    end

    def output_ext(ext)
      ".css"
    end

    def convert(content)
      engine = Sass::Engine.new(content)
      engine.render
    end
  end
end
