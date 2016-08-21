class SearchResult
  def initialize(query: '', search_type: 'meaning', language: nil)
    @query = query.downcase
    @search_type = search_type
    @language = language || SpreadsheetLanguage::ENGLISH
  end

  def words
    return [] unless @query.present?

    send("search_by_#{@search_type}", @query)
  end

  private

  def search_by_meaning(query)
    search_by_words(query)
  end

  def search_by_word(query)
    search_by_words(query)
  end

  def search_by_tag(query)
    Word.active.where(language: @language).tagged_with(query).by_word
  end

  def search_by_words(query)
    Word.active
      .where(language: @language)
      .where("lower(#{@search_type}) like :query", query: "%#{@query}%")
      .sort_by(&:word)
  end
end
