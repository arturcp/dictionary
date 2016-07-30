class WordsController < ApplicationController
  def index
    @words = SearchResult.new(search_params).words
  end

  private

  def search_params
    params.permit(
      :lang,
      :q,
      :search_type
    )
  end
end
