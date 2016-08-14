require 'rails_helper'

describe Importer do
  let(:worksheet) { double }
  let(:rows) do
    [
      ['Ineffable',	'Incapable of being expressed; indescribable or unutterable', 'ineffable joy', 'Hannet'],
      ['Testy', 'impatient, or exasperated; peevish', 'a testy refusal to help', 'Offense']
    ]
  end
  let(:importer) do
    Importer.new(
      file: '',
      language: SpreadsheetLanguage::ENGLISH,
      dictionary: Dictionaries::TheFreeDictionary
    )
  end

  before do
    allow(worksheet).to receive(:save)
    allow(worksheet).to receive(:[])
    allow(worksheet).to receive(:[]=)
    allow(worksheet).to receive(:rows).and_return(rows)
    allow_any_instance_of(Spreadsheet).to receive(:worksheet).and_return(worksheet)
  end

  describe '#rows_count' do
    it 'counts the number of rows' do
      expect(importer.rows_count).to eq(2)
    end
  end

  describe '#start!' do
    it 'imports the words to the database' do
      expect { importer.start! }.to change(Word, :count).by(2)
    end
  end
end
