require_relative '../lib/connect_four'
require_relative '../lib/gameboard'

describe ConnectFour do
  subject(:connectfour) { described_class.new }
  subject(:gameboard) { Gameboard.new }

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

  describe '#current_player' do
    context 'when circle takes their turn' do
      before do
        o_turn = [' |', ' |', ' |', 'X|', 'O|', ' |', ' |']
        allow(connectfour).to receive(:gameboard.board[0]).and_return(o_turn)
      end

      it 'returns cross' do
        expect(connectfour.current_player).to eq('X|')
      end
    end

    context 'when cross takes their turn' do
      before do
        gameboard.board[0] = [' |', ' |', ' |', 'X|', 'O|', ' |', ' |']

      end

      it 'returns circle' do
        expect(connectfour.current_player).to eq('O|')
      end
    end
  end
end
