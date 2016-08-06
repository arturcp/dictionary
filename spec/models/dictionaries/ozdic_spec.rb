require 'rails_helper'

describe Dictionaries::CollocationDictionary do
  describe '.url_for' do
    it 'builds the url to look the word up on the ozdic.com website' do
      expect(described_class.url_for('My Word')).to eq('http://ozdic.com/collocation-dictionary/my+word')
    end
  end
end
