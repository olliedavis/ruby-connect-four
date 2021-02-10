require_relative '../lib/connect_four'
require_relative '../lib/gameboard'

describe ConnectFour do
  subject(:connectfour) { described_class.new }
  subject(:board) { gameboard.new }

  describe '#player_input' do
    context 'when a valid input is provided' do
      before do
        allow(connectfour).to receive(:gets).and_return('4')
      end

      it 'validates and returns correct index' do
        result = connectfour.player_input
        expect(result).to eq(3)
      end
    end

    context 'when an invalid input is provided twice and then a valid input' do
      before do
        allow(connectfour).to receive(:gets).and_return('foo', 'bar', '5')
      end

      it 'validates and returns the correct index' do
        result = connectfour.player_input
        expect(result).to eq(4)
      end
    end
  end

  describe '#valid?' do
    context 'when a valid number is provided' do
      it 'returns true' do
        expect(connectfour.valid?(4)).to be true
      end
    end

    context 'when an invalid number is provided' do
      it 'returns false' do
        expect(connectfour.valid?(9)).to be false
      end
    end
  end

  describe '#won?' do
    context 'when a straight line of four is made' do
      before do
        connectfour.row_six = [' ', ' ', 'O', 'O', 'O', 'O', ' ']
      end

      xit 'returns true' do
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

      xit 'returns true' do
        expect(connectfour.won?).to be true
      end
    end

    context 'when a line of four has not been made' do
      xit 'returns false' do
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

      xit 'returns true' do
        expect(connectfour.full_board?).to be true
      end
    end

    context 'when there are positions left' do
      xit 'returns false' do
        expect(connectfour.full_board?).to be false
      end
    end
  end

  describe '#current_board' do
    context 'when called' do
      xit 'returns the current board' do
        expect(board.current_board).to receive(:current_board)
      end
    end
  end
end
