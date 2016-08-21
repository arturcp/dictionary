class Word < ActiveRecord::Base
  before_save :set_active_status, :capitalize_word
  acts_as_taggable

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :by_word, -> { order('word ASC') }

  def valid_entry?
    less_than_two_words? &&
      contains_valid_characters? &&
      word.strip.present?
  end

  private

  def less_than_two_words?
    (word || '').split(' ').length <= 2
  end

  def contains_valid_characters?
    /^[[:alpha]][[:alpha:]0-9 \-]*$/.match(word).present?
  end

  def set_active_status
    return unless self.active.nil?

    self.active = valid_entry?
  end

  def capitalize_word
    self.word = self.word.capitalize
  end
end
