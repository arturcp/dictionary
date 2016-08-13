require 'nokogiri'
require 'open-uri'

module Dictionaries
  class TheFreeDictionary
    def self.look_up(word)
      doc = Nokogiri::HTML(open(url_for(word)))
      definition = doc.css('#Definition')[0].css('section')[0].to_s
      cleanup(definition)
    rescue
      ''
    end

    def self.url_for(word)
      "http://thefreedictionary.com/#{CGI::escape(word.downcase)}"
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
      %w{pron brand_copy snd flImg}.include?(node['class'])
    end

    def self.formatted_fragment(fragment)
      fragment = fragment.gsub("\n\n\n", "\n")

      parts = fragment.split("\n")
      # 2.times { parts.shift }
      parts.shift
      parts.shift if invalid_part?(parts[0])
      parts.join("\n")
    end

    def self.invalid_part?(part)
      part == " Â "
    end
  end
end
