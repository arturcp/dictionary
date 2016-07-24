require 'rails_helper'
require 'matrix'

describe Spreadsheet do
  describe '#worksheet' do
    let(:spreadsheet) do
      double(worksheets: [Matrix.rows([[1,2], [3,4]])])
    end

    let(:worksheet) { Spreadsheet.new(file: '1234').worksheet(0) }

    before do
      allow_any_instance_of(Spreadsheet).to receive(:spreadsheet).and_return(spreadsheet)
    end

    it { expect(worksheet[0, 0]).to eq(1) }
    it { expect(worksheet[0, 1]).to eq(2) }
    it { expect(worksheet[1, 0]).to eq(3) }
    it { expect(worksheet[1, 1]).to eq(4) }
  end
end
