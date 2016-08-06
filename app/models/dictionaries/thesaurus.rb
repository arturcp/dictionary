module Dictionaries
  class Thesaurus
    def self.url_for(word)
      "http://www.thesaurus.com/browse/#{CGI::escape(word.downcase)}"
    end
  end
end
