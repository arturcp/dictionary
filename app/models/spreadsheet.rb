require 'google_drive'

class Spreadsheet
  def initialize(file:)
    @file = file
  end

  def worksheet(index)
    spreadsheet.worksheets[index]
  end

  private

  def spreadsheet
    @spreadsheet ||= begin
      session = GoogleDrive.saved_session(config_path)
      session.spreadsheet_by_key(@file)
    end
  end

  def config_path
    Rails.root.join('config/google_api.json').to_s
  end
end
