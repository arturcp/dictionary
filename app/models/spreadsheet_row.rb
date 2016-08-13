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
      word: row[WORD].downcase,
      meaning: row[MEANING],
      example: row[EXAMPLE],
      language: language
    )
  end

  def save_tags(word)
    return unless tags.present?

    word.tag_list.add(tags, parse: true)
    word.save!
  end

  private

  def tags
    @tags ||= format(row[TAG])
  end

  def format(text)
    text.downcase.delete('*').strip
  end
end
