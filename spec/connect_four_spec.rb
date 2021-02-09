require_relative '../lib/connect_four'
require_relative '../lib/board'

describe ConnectFour do
  subject(:connectfour) { described_class.new }
  subject(:board) { gameboard.new }

  describe '#input_to_index' do
    context 'when an input is provided' do
      it 'converts to matching index' do
        expect (connectfour.input_to_index(4)).to eq(5)
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
        expect (connectfour.counter_drop(3, 'O')).to change { connectfour.row_five[3] }.from (' ').to('O')
      end
    end
  end

  describe '#won?' do
    context 'when a straight line of four is made' do
      before do
        connectfour.row_six = [' ', ' ', 'O', 'O', 'O', 'O', ' ']
      end

      it 'returns true' do
        expect(connectfour.won?).to be true
      end
    end

    context 'when a diagonal line of four is made' do
      before do
        connectfour.row_three = [' ', ' ', ' ', ' ', 'O', ' ', ' ']
        connectfour.row_four = [' ', ' ', ' ', 'O', 'X', ' ', ' ']
        connectfour.row_five = [' ', ' ', 'O', 'X', 'X', 'O', ' ']
        connectfour.row_six = [' ', ' O', 'X', 'X', 'X', 'O ', ' ']
      end

      it 'returns true' do
        expect(connectfour.won?).to be true
      end
    end

    context 'when a line of four has not been made' do
      it 'returns false' do
        expect(connectfour.won?).to be false
      end
    end
  end

  describe '#full_board?' do
    context 'when there are no positions left' do
      before do
        gameboard.board.row_one = ['O'] * 7
        gameboard.board.row_two = ['O'] * 7
        gameboard.board.row_three = ['O'] * 7
        gameboard.board.row_four = ['O'] * 7
        gameboard.board.row_five = ['O'] * 7
        gameboard.board.row_six = ['O'] * 7
      end

      it 'returns true' do
        expect(connectfour.full_board?).to be true
      end
    end

    context 'when there are positions left' do
      it 'returns false' do
        expect(connectfour.full_board?).to be false
      end
    end
  end

  describe '#current_board' do
    context 'when called' do
      it 'returns the current board' do
        expect(board.current_board).to receive(:current_board)
      end
    end
  end
end
