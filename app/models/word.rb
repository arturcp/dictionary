class Word < ActiveRecord::Base
  def valid_entry?
    word.split(' ').length <= 2
  end
end
