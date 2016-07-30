require 'rails_helper'

describe Word do
  describe '#valid_entry?' do
    context 'when there are three or more words' do
      it 'is not valid' do
        expect(Word.new(word: 'lorem ipsum dolor')).not_to be_valid_entry
      end
    end

    context 'when there are two words' do
      it 'is valid' do
        expect(Word.new(word: 'lorem ipsum')).to be_valid_entry
      end
    end

    context 'when there is one word' do
      it 'is valid' do
        expect(Word.new(word: 'lorem')).to be_valid_entry
      end
    end

    context 'when the word is empty' do
      it 'is not valid' do
        expect(Word.new(word: '')).not_to be_valid_entry
      end
    end

    context 'when the word is nil' do
      it 'is not valid' do
        expect(Word.new).not_to be_valid_entry
      end
    end

    context 'when the word has only numbers' do
      it 'is not valid' do
        expect(Word.new(word: '12345')).not_to be_valid_entry
      end
    end
  end

  describe '#active' do
    context 'when the word is invalid' do
      let(:word) { Word.new(word: '') }

      it 'sets the active status to false' do
        word.save
        expect(word.active).to eq(false)
      end
    end

    context 'when the word is valid' do
      let(:word) { Word.new(word: 'loren ipsum') }

      it 'sets the active status to true' do
        word.save
        expect(word.active).to eq(true)
      end
    end
  end

  describe '#save' do
    let(:word) { Word.new(word: 'LOREN iPsUm') }

    it 'capitalizes the word' do
      word.save!
      expect(word.word).to eq('Loren ipsum')
    end
  end
end
