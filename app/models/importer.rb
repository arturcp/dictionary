# Public: import worksheets from a Google Drive spreadsheet.
#
# There is an expected spreadsheet format:
#
# * All languages must be in the same file, but in different worksheets
# * The order of the languages is, respectively, Portuguese, English and Italian
# * Each worksheet has 4 columns: word, definition, examples and tags
class Importer
  attr_reader :file, :language, :worksheet

  def initialize(file:, language:, dictionary:)
    @file = file
    @language = language
    @dictionary = dictionary
    @worksheet = Spreadsheet.new(file: file).worksheet(language)
  end

  def start!(&block)
    @ignored_list = []
    worksheet.rows.each_with_index do |row, index|
      word = save_word(row)
      worksheet[index + 1, 2] = word.meaning if worksheet[index + 1, 2].blank?

      yield(row) if block_given?
    end

    worksheet.save
  end

  def rows_count
    worksheet.rows.count
  end

  private

  def save_word(row)
    SpreadsheetRow.new(row, language).to_w.tap do |candidate|
      candidate.meaning = @dictionary.look_up(candidate.word) if candidate.meaning.blank?
      candidate.active = false unless candidate.meaning
      candidate.save!
    end
  end
end
