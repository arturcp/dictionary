require 'rails_helper'

describe SpreadsheetRow do
  let(:language) { SpreadsheetLanguage::ENGLISH }
  let(:row) { ['reeling', 'Sustained noise, as from hammering', 'reel in a large fish', 'noise, sound'] }
  subject { described_class.new(row, language) }

  describe '#to_w' do
    it 'returns an instance of a word' do
      entry = subject.to_w
      expect(entry.word).to eq('reeling')
      expect(entry.meaning).to eq('Sustained noise, as from hammering')
      expect(entry.example).to eq('reel in a large fish')
      expect(entry.language).to eq(language)
    end

    context 'word cleanup' do
      let(:row) { ['reeling*,!.:', 'Sustained noise, as from hammering', 'reel in a large fish', 'noise, sound'] }
      let(:entry) { subject.to_w }

      it { expect(entry.word).to eq('reeling') }
    end
  end

  describe '#tags' do
    context 'when there are tags' do
      it 'removes asterisks from the tags' do
        row[3] = '** noise, sound **'
        expect(subject.tags).to eq('noise, sound')
      end

      it 'uses only downcase letters' do
        row[3] = 'NOISE, SOUND'
        expect(subject.tags).to eq('noise, sound')
      end

      it 'removes extra spaces' do
        row[3] = '   noise, sound   '
        expect(subject.tags).to eq('noise, sound')
      end

      it 'removes exclamations' do
        row[3] = 'noise!'
        expect(subject.tags).to eq('noise')
      end

      it 'removes points' do
        row[3] = 'noise.'
        expect(subject.tags).to eq('noise')
      end

      it 'removes colons' do
        row[3] = 'noise:'
        expect(subject.tags).to eq('noise')
      end
    end

    context 'when there are no tags' do
      it 'is empty' do
        row[3] = ''
        expect(subject.tags).to be_empty
      end
    end
  end
end
