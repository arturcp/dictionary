class SearchResult
  def initialize(query: '', search_type: 'meaning', language: nil)
    @query = query.downcase
    @search_type = search_type
    @language = language || SpreadsheetLanguage::ENGLISH
  end

  def words
    return [] unless @query.present?

    Word.active
      .where("lower(#{@search_type}) like :query", query: "%#{@query}%")
      .sort_by(&:word)
  end
end
