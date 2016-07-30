class WordsController < ApplicationController
  def index
    @words = search_result
  end

  private

  def search_result
    @search_result ||= SearchResult.new(
      q: search_params[:q],
      search_type: search_params[:search_type]
    ).words
  end

  def search_params
    params.permit(
      :lang,
      :q,
      :search_type
    )
  end
end
