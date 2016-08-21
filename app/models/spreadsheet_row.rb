class SpreadsheetRow
  WORD = 0
  MEANING = 1
  EXAMPLE = 2
  TAG = 3

  TAG_BLACK_LIST = '*!.:'
  WORD_BLACK_LIST = '*,!.:'

  attr_reader :row, :language

  def initialize(row, language)
    @row = row
    @language = language
  end

  def to_w
    Word.new(
      word: format(row[WORD], WORD_BLACK_LIST),
      meaning: row[MEANING],
      example: row[EXAMPLE],
      language: language
    )
  end

  def tags
    @tags ||= format(row[TAG], TAG_BLACK_LIST)
  end

  private

  def format(text, black_list)
    text.to_s.downcase.delete(black_list).strip
  end
end
