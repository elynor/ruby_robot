require 'rspec'
require_relative '../robot'

describe Robot do
  before(:all) do
    map = Map.new(5, 5)
    @robot = described_class.new(map)
  end

  describe '#send_command' do
    it 'Should not accept commands before placing' do
      response = @robot.send_command('move')
      expect(response).to eq('Robot was not initialized!')
    end

    it 'Should not place robot if the tile is not available' do
      response = @robot.send_command('place 10 10 north')
      expect(response).to eq('Beep. The end of the map!')
      response = @robot.send_command('left')
      expect(response).to eq('Robot was not initialized!')
    end

    it 'Should not not place the robot if direction is wrong' do
      response = @robot.send_command('place 10 10 moon')
      expect(response).to eq('Wrong direction!')
    end

    it 'Should not accept command string separated by anything but spaces' do
      response = @robot.send_command('place 10,10,moon')
      expect(response).to eq('Separator should be a space')
    end

    it 'Places the robot if the tile is ok' do
      response = @robot.send_command('place 0 0 north')
      expect(response).to eq('Position is: 0 | 0, facing: north')
    end

    it 'Should not accept unknown commands' do
      response = @robot.send_command('fly')
      expect(response).to eq('Unknown command!')
    end

    it 'Should turn the robot left properly' do
      response = @robot.send_command('left')
      expect(response).to eq('Position is: 0 | 0, facing: west')
    end

    it 'Should turn the robot right properly' do
      response = @robot.send_command('right')
      expect(response).to eq('Position is: 0 | 0, facing: north')
    end

    it 'Should move the robot properly if the next tile exists' do
      response = @robot.send_command('move')
      expect(response).to eq('Position is: 0 | 1, facing: north')
    end

    it 'Should not move if tile is not available' do
      @robot.send_command('left')
      response = @robot.send_command('move')
      expect(response).to eq('Beep. The end of the map!')
    end

    it 'Rotates correctly' do
      3.times { @robot.send_command('left') }
      response = @robot.send_command('left')
      expect(response).to eq('Position is: 0 | 1, facing: west')
      3.times { @robot.send_command('right') }
      response = @robot.send_command('right')
      expect(response).to eq('Position is: 0 | 1, facing: west')
    end
  end
end
