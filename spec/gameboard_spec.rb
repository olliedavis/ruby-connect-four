require_relative '../lib/gameboard'
require_relative '../lib/connect_four'

describe Gameboard do
  subject(:gameboard) { described_class.new }
  subject(:connectfour) { ConnectFour.new }

  describe 'counter_drop' do
    context 'when an empty column is chosen' do
      xit 'puts the piece in the lowest position' do
        expect { gameboard.counter_drop(0, 'O|') }.to change { gameboard.instance_variable_get(:@row_six)[0] }.from(' |').to('O|')
      end
    end

    context 'when a non-empty column is chosen' do
      before do
        gameboard.instance_variable_get(:@row_six)[3] = 'O|'
      end

      xit 'puts the piece at the lowest available position' do
        expect { gameboard.counter_drop(3, 'O|') }.to change { gameboard.instance_variable_get(:@row_five)[3] }.from(' |').to('O|')
      end
    end
  end

  describe '#won_straight_line?' do
    context 'when a straight line of four is made' do
      before do
        subject.instance_variable_set(:@row_six, [' |', ' |', 'O|', 'O|', 'O|', 'O|', ' |'])
      end

      it 'returns true' do
        subject.instance_variable_set(:@row_six, [' |', ' |', 'O|', 'O|', 'O|', 'O|', ' |'])
        expect(gameboard.won_straight_line?).to be true
      end
    end

  describe '#won_diagonal?'
    context 'when a diagonal line of four is made' do
      before do
        gameboard.instance_variable_set(:@row_three, [' |', ' |', ' |', ' |', ' |', ' |', ' |'])
        gameboard.instance_variable_set(:@row_four, [' |', ' |', ' |', 'O|', 'X|', ' |', ' |'])
        gameboard.instance_variable_set(:@row_five, [' |', ' |', 'O|', 'X|', 'X|', 'O|', ' |'])
        gameboard.instance_variable_set(:@row_six, [' |', ' O|', 'X|', 'X|', 'X|', 'O|', ' |'])
      end

      xit 'returns true' do
        expect(connectfour.won_diagonal?).to be true
      end
    end
  end


  describe '#full_board?' do
    context 'when there are no positions left' do
      before do
        gameboard.instance_variable_set(:@row_one, ['O|'] * 7)
        gameboard.instance_variable_set(:@row_two, ['O|'] * 7)
        gameboard.instance_variable_set(:@row_three, ['O|'] * 7)
        gameboard.instance_variable_set(:@row_four, ['O|'] * 7)
        gameboard.instance_variable_set(:@row_five, ['O|'] * 7)
        gameboard.instance_variable_set(:@row_six, ['O|'] * 7)
      end

      xit 'returns true' do
        expect(gameboard.full_board?).to be true
      end
    end

    context 'when there are positions left' do
      xit 'returns false' do
        expect(gameboard.full_board?).to be false
      end
    end
  end
end
