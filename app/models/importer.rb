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
    word_count = Word.where(language: language).count

    worksheet.rows.each_with_index do |row, index|
      next if index < word_count

      word = save_word(row)

      if worksheet[index + 1, 2].blank?
        worksheet[index + 1, 2] = word.meaning
        begin
          worksheet.save if index % 10 == 0
        rescue
        end
      end

      yield(row) if block_given?
    end

    worksheet.save
  end

  def rows_count
    worksheet.rows.count
  end

  private

  def save_word(row)
    spreadsheet_row = SpreadsheetRow.new(row, language)
    spreadsheet_row.to_w.tap do |entry|
      entry.meaning = @dictionary.look_up(entry.word) if entry.meaning.blank?
      entry.active = false unless entry.meaning
      entry.tag_list.add(spreadsheet_row.tags, parse: true) if spreadsheet_row.tags.present?
      entry.save!
    end
  end
end
