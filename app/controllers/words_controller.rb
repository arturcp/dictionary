class WordsController < ApplicationController
  def index
    words = Word.active.where('word like :query', query: "#{search_params[:q]}%")
    render json: words
  end

  private

  def lang
    search_params[:lang] || SpreadsheetLanguage::ENGLISH
  end

  def search_params
    params.permit(
      :lang,
      :q
    )
  end

end
