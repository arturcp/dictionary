class WordsController
  def index

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
