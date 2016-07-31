require 'nokogiri'
require 'open-uri'

module Dictionaries
  class TheFreeDictionary
    def self.look_up(word)
      url = "http://thefreedictionary.com/#{CGI::escape(word)}"
      doc = Nokogiri::HTML(open(url))
      definition = doc.css('#Definition')[0].css('section')[0].to_s
      cleanup(definition)
    rescue
      ''
    end

    private

    def self.cleanup(definition)
      definition = definition.split('<hr align="left" class="hmshort">').first
      cleanup = Loofah::Scrubber.new do |node|
        if invalid_node?(node)
          node.remove
        end
      end

      fragment = Loofah.fragment(definition).scrub!(:strip).scrub!(cleanup)

      formatted_fragment(fragment.content)
    end

    def self.invalid_node?(node)
      invalid_tag?(node) || invalid_class?(node)
    end

    def self.invalid_tag?(node)
      %w{h1 h2 h3 h4}.include?(node.name)
    end

    def self.invalid_class?(node)
      %w{pron brand_copy}.include?(node['class'])
    end

    def self.formatted_fragment(fragment)
      parts = fragment.split("\n")
      # 2.times { parts.shift }
      parts.shift
      parts.join("\n")
    end
  end
end
