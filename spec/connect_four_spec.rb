require 'time'
require_relative '../lib/connect_four'
require_relative '../lib/gameboard'
require_relative '../lib/save_game'

describe ConnectFour do
  subject(:connectfour) { described_class.new }

  describe '#player_input' do
    context 'when a valid input is provided' do
      before do
        allow(connectfour).to receive(:gets).and_return('4')
      end

      it 'validates and returns correct index' do
        result = connectfour.player_input('O|')
        expect(result).to eq(3)
      end
    end

    context 'when an invalid input is provided twice and then a valid input' do
      before do
        allow(connectfour).to receive(:gets).and_return('foo', 'bar', '5')
      end

      it 'validates and returns the correct index' do
        result = connectfour.player_input('X|')
        expect(result).to eq(4)
      end
    end
  end

  describe '#save_load_valid?' do
    context 'when a valid number is provided' do
      it 'returns true' do
        expect(connectfour.save_load_valid?(4)).to be true
      end
    end

    context 'when an invalid number is provided' do
      it 'returns false' do
        expect(connectfour.save_load_valid?(15)).to be false
      end
    end
  end

  describe '#current_player' do
    context 'when circle takes their turn' do
      it 'returns cross' do
        connectfour.instance_variable_get(:@board)[5] = [' |', ' |', ' |', 'X|', 'O|', ' |', ' |']
        expect(connectfour.current_player).to eq('X|')
      end
    end

    context 'when cross takes their turn' do
      it 'returns circle' do
        connectfour.instance_variable_get(:@board)[5] = [' |', ' |', ' |', 'X|', ' |', ' |', ' |']
        expect(connectfour.current_player).to eq('O|')
      end
    end
  end

  describe '#unique_file_name?' do
    context 'when a unique file name is given' do
      it 'returns true' do
        expect(connectfour.unique_file_name?(Time.now)).to be true
      end
    end
    context 'when a non unique file name is given' do
      before do
        SaveGame.new('not-unique', Gameboard.new.board)
      end

      it 'returns false' do
        expect(connectfour.unique_file_name?('not-unique')).to be false
      end
    end
  end
end
