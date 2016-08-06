module EnglishCardHelper
  def link_to_dictionary(word)
    link_to 'Dictionary', Dictionaries::TheFreeDictionary.url_for(word), target: :blank
  end

  def link_to_thesaurus(word)
    link_to 'Thesaurus', Dictionaries::Thesaurus.url_for(word), target: :blank
  end
end
