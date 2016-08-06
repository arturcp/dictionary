require 'rails_helper'

describe Dictionaries::TheFreeDictionary do
  describe '#url_for' do
    it 'builds the url to look the word up on the The Free Dictionary website' do
      expect(described_class.url_for('My Word')).to eq('http://thefreedictionary.com/my+word')
    end
  end
end
