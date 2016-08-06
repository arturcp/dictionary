module EnglishCardHelper
  def link_to_dictionary(word)
    link_to 'Dictionary', Dictionaries::TheFreeDictionary.url_for(word), target: :blank
  end
end
