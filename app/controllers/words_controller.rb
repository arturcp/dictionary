class WordsController < ApplicationController
  def index
    @word = search_params[:query]
    @search_type = search_params[:search_type]
    @language = search_params[:language]
    @words = search_result
  end

  private

  def search_result
    @search_result ||= SearchResult.new(
      query: search_params[:query],
      search_type: search_params[:search_type]
    ).words
  end

  def search_params
    @search_params ||= params.permit(
      :language,
      :query,
      :search_type
    )
  end
end
