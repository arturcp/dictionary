require 'rails_helper'

describe SearchResult do
  before do
    create(:word, word: 'swerve', meaning: 'To turn aside or be turned aside from a straight path or established pattern')
    neophyte = create(:word, word: 'neophyte', meaning: 'A recent convert to a belief; a proselyte.')
    create(:word, word: 'behest', meaning: 'An authoritative command.')
    create(:word, word: 'enraged', meaning: 'To put into a rage; infuriate.')
    consigned = create(:word, word: 'consigned', meaning: 'To give over to the care or custody of another.')

    neophyte.tag_list.add('awesome', 'slick')
    neophyte.save

    consigned.tag_list.add('awesome')
    consigned.save
  end

  describe '#words' do
    context 'when the search is by meaning' do
      let(:search_type) { SearchType::MEANING }

      context 'and the query is empty' do
        subject { SearchResult.new(search_type: search_type) }

        it { expect(subject.words).to be_empty }
      end

      context 'and the query is provided' do
        subject { SearchResult.new(search_type: search_type, query: 'rage') }

        it { expect(subject.words.count).to eq(1) }
      end

      context 'when the query does not match word case' do
        subject { SearchResult.new(search_type: SearchType::MEANING, query: 'Care') }

        it { expect(subject.words.count).to eq(1) }
      end
    end

    context 'when the search is by word' do
      let(:search_type) { SearchType::WORD }

      context 'and the query is empty' do
        subject { SearchResult.new(search_type: search_type) }

        it { expect(subject.words).to be_empty }
      end

      context 'and the query is provided' do
        subject { SearchResult.new(search_type: search_type, query: 'behest') }

        it { expect(subject.words.count).to eq(1) }
      end

      context 'when the query does not match word case' do
        subject { SearchResult.new(search_type: SearchType::WORD, query: 'Behest') }

        it { expect(subject.words.count).to eq(1) }
      end
    end

    context 'when the search is by tag' do
      subject { SearchResult.new(search_type: SearchType::TAG, query: 'Awesome') }

      it { expect(subject.words.count).to eq(2) }
    end

    context 'when the list includes inactive words' do
      it 'ignores the inactive word' do
        create(:word, :inactive, word: 'fake', meaning: 'another word with rage')
        result = SearchResult.new(search_type: SearchType::MEANING, query: 'rage')
        expect(result.words.count).to eq(1)
      end
    end

    context 'when the query searches for a part of a word' do
      subject { SearchResult.new(search_type: SearchType::WORD, query: 'herring') }
      let!(:double_word) { create(:word, word: 'red herring') }

      it { expect(subject.words.count).to eq(1) }
    end
  end
end
