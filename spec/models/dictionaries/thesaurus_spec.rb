require 'rails_helper'

describe Dictionaries::Thesaurus do
  describe '.url_for' do
    it 'builds the url to look the word up on the Thesaurus website' do
      expect(described_class.url_for('My Word')).to eq('http://www.thesaurus.com/browse/my+word')
    end
  end
end
