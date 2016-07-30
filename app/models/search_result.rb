class SearchResult
  def initialize(q: '', search_type: 'meaning', lang: nil)
    @query = q.downcase
    @search_type = search_type
    @language = lang || SpreadsheetLanguage::ENGLISH
  end

  def words
    return [] unless @query.present?

    Word.active.where("lower(#{@search_type}) like :query", query: "%#{@query}%")
  end
end
