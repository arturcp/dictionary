require 'nokogiri'
require 'open-uri'

module Dictionaries
  class Dicio
    def self.look_up(word)
      doc = Nokogiri::HTML(open(url_for(word)))
      definition = doc.css('#significado')[0].to_s
      cleanup(definition)
    rescue
      ''
    end

    def self.url_for(word)
      "http://dicio.com.br/#{word.parameterize}"
    end

    private

    def self.cleanup(definition)
      cleanup = Loofah::Scrubber.new do |node|
        node.remove if invalid_class?(node)
      end

      Loofah
        .fragment(definition)
        .scrub!(:strip)
        .scrub!(cleanup)
        .content
    end

    def self.invalid_class?(node)
      %w{cl}.include?(node['class'])
    end
  end
end
