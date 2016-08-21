class SpreadsheetRow
  WORD = 0
  MEANING = 1
  EXAMPLE = 2
  TAG = 3

  attr_reader :row, :language

  def initialize(row, language)
    @row = row
    @language = language
  end

  def to_w
    Word.new(
      word: format(row[WORD]),
      meaning: row[MEANING],
      example: row[EXAMPLE],
      language: language
    )
  end

  def tags
    @tags ||= format(row[TAG])
  end

  private

  def format(text)
    text.to_s.downcase.delete('*,!.:').strip
  end
end
