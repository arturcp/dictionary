require 'nokogiri'
require 'open-uri'

module Dictionaries
  class TheFreeDictionary
    def self.look_up(word)
      url = "http://thefreedictionary.com/#{CGI::escape(word)}"
      doc = Nokogiri::HTML(open(url))
      definition = doc.css('#Definition')[0].to_s
      cleanup(definition)
    end

    private

    def self.cleanup(definition)
      definition = definition.split('<hr align="left" class="hmshort">').first
      definition = definition.gsub(' id="Definition"', '')
      Loofah.fragment(definition).scrub!(:strip).to_s
    end
  end
end
