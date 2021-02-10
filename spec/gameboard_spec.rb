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
end
