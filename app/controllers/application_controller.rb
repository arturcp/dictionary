class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :load_language

  LANGUAGES = {
    'portuguese' => SpreadsheetLanguage::PORTUGUESE,
    'english' => SpreadsheetLanguage::ENGLISH,
    'italian' => SpreadsheetLanguage::ITALIAN,
  }.freeze

  protected

  def load_language
    @language = params[:language]
    @language_code = LANGUAGES[@language]

    redirect_to root_path('english') unless @language
  end
end
