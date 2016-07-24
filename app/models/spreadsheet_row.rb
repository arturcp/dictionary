class SpreadsheetRow
  WORD = 0
  MEANING = 1
  EXAMPLE = 2

  attr_reader :row, :language

  def initialize(row, language)
    @row = row
    @language = language
  end

  def to_w
    Word.new(
      word: row[WORD],
      meaning: row[MEANING],
      example: row[EXAMPLE],
      language: language
    )
  end
end
