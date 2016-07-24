class Word < ActiveRecord::Base
  scope :unseen, -> (user) { where(user: user, seen: false) }

  def valid_entry?
     less_than_two_words? && contains_letters?
  end

  private

  def less_than_two_words?
    (word || '').split(' ').length <= 2
  end

  def contains_letters?
    /^\d*[a-z][a-z0-9 ]*$/.match(word)
  end
end
