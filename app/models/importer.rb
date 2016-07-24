# Public: import worksheets from a Google Drive spreadsheet.
#
# There is an expected spreadsheet format:
#
# * All languages must be in the same file, but in different worksheets
# * The order of the languages is, respectively, Portuguese, English and Italian
# * Each worksheet has 4 columns: word, definition, examples and tags
class Importer
  PORTUGUESE = 1
  ENGLISH = 0

  attr_reader :file, :worksheet

  def initialize(file:, language:)
    @file = file
    @worksheet = Spreadsheet.new(file: file).worksheet(language)
  end

  def start!(&block)
    worksheet.rows.each do |row|
      yield(row) if block_given?
    end
  end

  def rows_count
    worksheet.rows.count
  end
end
