require '../lib/connect-four'

describe ConnectFour do
  subject(:connectfour) { described_class.new }

  describe '#counter_drop' do
    context 'when an empty column is chosen' do
      it 'puts the piece in the lowest position' do
        expect (connectfour.counter_drop(0, 'O')).to change { connectfour.row_six[0] }.from (' ').to('O')
      end
    end

    context 'when a non-empty column is chosen' do
      before do
        row_six[3] = 'O'
      end

      it 'puts the piece at the lowest available position' do
        expect (connectfour.counter_drop(3, 'O')).to change { connectfour.row_five[3]}.from (' ').to('O')
      end
    end
  end

  describe '#valid?' do
    context 'when a valid number is provided' do
      it 'returns true' do
        expect (connectfour.valid?(4)).to be true
      end
    end

    context 'when an invalid number is provided' do
      it 'returns false' do
        expect (connectfour.valid?(9)).to be false
      end
    end
  end
end
