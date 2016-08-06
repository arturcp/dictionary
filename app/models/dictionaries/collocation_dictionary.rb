module Dictionaries
  class CollocationDictionary
    def self.url_for(word)
      "http://ozdic.com/collocation-dictionary/#{CGI::escape(word.downcase)}"
    end
  end
end
