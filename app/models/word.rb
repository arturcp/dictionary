class Word < ActiveRecord::Base
  before_save :set_active_status, :capitalize_word
  acts_as_taggable

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }

  def valid_entry?
    less_than_two_words? && contains_letters?
  end

  private

  def less_than_two_words?
    (word || '').split(' ').length <= 2
  end

  def contains_letters?
    /^\d*[a-z][a-z0-9 \-]*$/.match(word).present?
  end

  def set_active_status
    return unless self.active.nil?

    self.active = valid_entry?
  end

  def capitalize_word
    self.word = self.word.capitalize
  end
end
