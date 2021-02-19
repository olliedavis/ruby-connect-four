require_relative '../lib/gameboard'
require_relative '../lib/connect_four'

describe Gameboard do
  subject(:gameboard) { described_class.new }
  subject(:connectfour) { ConnectFour.new }

  describe 'counter_drop' do
    context 'when an empty column is chosen' do
      it 'puts the piece in the lowest position' do
        expect { gameboard.counter_drop(0, 'O|') }.to change {
                                                        gameboard.instance_variable_get(:@board)[5][0]
                                                      }.from(' |').to('O|')
      end
    end

    context 'when a non-empty column is chosen' do
      before do
        gameboard.instance_variable_get(:@board)[5][3] = 'X|'
      end

      it 'puts the piece at the lowest available position' do
        expect { gameboard.counter_drop(3, 'O|') }.to change {
                                                        gameboard.instance_variable_get(:@board)[4][3]
                                                      }.from(' |').to('O|')
      end
    end
  end

  describe '#won_straight_line?' do
    context 'when a straight line of four is made' do
      it 'returns true' do
        gameboard.instance_variable_get(:@board)[0] = [' |', ' |', ' |', 'X|', 'X|', 'X|', 'X|']
        expect(gameboard.won_straight_line?).to be true
      end
    end

    context 'when a straight line of four is not made' do
      it 'returns false' do
        gameboard.instance_variable_get(:@board)[0] = [' |', ' |', ' |', 'X|', 'O|', 'X|', 'X|']
        expect(gameboard.won_straight_line?).to be false
      end
    end
  end

  describe '#won_diagonal?' do
    context 'when a winning forward diagonal line of four is made' do
      before do
        board = gameboard.instance_variable_get(:@board)
        board[3] = [' |', ' |', ' |', ' |', ' |', ' |', 'X|']
        board[2] = [' |', ' |', ' |', ' |', 'O|', 'X|', 'O|']
        board[1] = [' |', ' |', ' |', 'O|', 'X|', 'X|', 'O|']
        board[0] = [' |', ' |', ' |', 'X|', 'X|', 'X|', 'O|']
      end

      it 'returns true' do
        expect(gameboard.won_diagonal?).to be true
      end
    end

    context 'when a winning backwards diagonal line of four is made' do
      before do
        board = gameboard.instance_variable_get(:@board)
        board[3] = [' |', ' |', ' |', 'O|', ' |', ' |', 'X|']
        board[2] = [' |', ' |', ' |', 'X|', 'O|', 'X|', 'O|']
        board[1] = [' |', ' |', ' |', 'O|', 'O|', 'O|', 'O|']
        board[0] = [' |', ' |', ' |', 'O|', 'X|', 'X|', 'O|']
      end

      it 'returns true' do
        expect(gameboard.won_diagonal?).to be true
      end
    end

    context 'when no diagonal line of four is made' do
      it 'returns nil' do
        expect(gameboard.won_diagonal?).to be false
      end
    end
  end

  describe '#full_board?' do
    context 'when there are no positions left' do
      before do
        board = gameboard.instance_variable_get(:@board)
        board[0] = ['O|'] * 7
        board[1] = ['X|'] * 7
        board[2] = ['O|'] * 7
        board[3] = ['X|'] * 7
        board[4] = ['O|'] * 7
        board[5] = ['X|'] * 7
      end

      it 'returns true' do
        expect(gameboard.full_board?).to be true
      end
    end

    context 'when there are positions left' do
      it 'returns false' do
        expect(gameboard.full_board?).to be false
      end
    end
  end
end
