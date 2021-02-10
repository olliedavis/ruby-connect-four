require_relative '../lib/gameboard'

describe Gameboard do
  subject(:board) { described_class.new }

  describe '#counter_drop' do
    context 'when an empty column is chosen' do
      it 'puts the piece in the lowest position' do
        expect { board.counter_drop(0, 'O') }.to change { board.instance_variable_get(:@row_six)[0] }.from(' ').to('O')
      end
    end

    context 'when a non-empty column is chosen' do
      before do
        board.instance_variable_get(:@row_six)[3] = 'O'
      end

      it 'puts the piece at the lowest available position' do
        expect { board.counter_drop(3, 'O') }.to change { board.instance_variable_get(:@row_five)[3] }.from(' ').to('O')
      end
    end
  end

  describe '#won?' do
    context 'when a straight line of four is made' do
      before do
        board.row_six = [' ', ' ', 'O', 'O', 'O', 'O', ' ']
      end

      xit 'returns true' do
        expect(connectfour.won?).to be true
      end
    end

    context 'when a diagonal line of four is made' do
      before do
        board.instance_variable_set(:@row_three, [' ', ' ', ' ', ' ', 'O', ' ', ' '])
        board.instance_variable_set(:@row_four, [' ', ' ', ' ', 'O', 'X', ' ', ' '])
        board.instance_variable_set(:@row_five, [' ', ' ', 'O', 'X', 'X', 'O', ' '])
        board.instance_variable_set(:@row_six, [' ', ' O', 'X', 'X', 'X', 'O ', ' '])
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
        board.instance_variable_set(:@row_one, ['O'] * 7)
        board.instance_variable_set(:@row_two, ['O'] * 7)
        board.instance_variable_set(:@row_three, ['O'] * 7)
        board.instance_variable_set(:@row_four, ['O'] * 7)
        board.instance_variable_set(:@row_five, ['O'] * 7)
        board.instance_variable_set(:@row_six, ['O'] * 7)
      end

      it 'returns true' do
        expect(board.full_board?).to be true
      end
    end

    context 'when there are positions left' do
      it 'returns false' do
        expect(board.full_board?).to be false
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

