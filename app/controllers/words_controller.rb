class WordsController < ApplicationController
  def index
    find_words
  end

  private

  def lang
    search_params[:lang] || SpreadsheetLanguage::ENGLISH
  end

  def find_words
    @words = []
    return unless search_params[:q]

    @words = Word.active.where('word like :query', query: "#{search_params[:q]}%")
  end

  def search_params
    params.permit(
      :lang,
      :q
    )
  end
end
