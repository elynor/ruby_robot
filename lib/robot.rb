require 'world/map'

class NotInitializedError < StandardError
end

class WrongDirectionError < StandardError
end

class TileNotAvailable < StandardError
end

class Robot
  def initialize(map_object)
    @simple_commands = %w(left right move)
    @param_commands = %w(place)
    @position_x = nil
    @position_y = nil
    @facing = nil
    @map = map_object
    @vector = {
      north: [0, 1],
      south: [0, -1],
      west: [-1, 0],
      east: [1, 0]
    }
  end

  def send_command(command)
    parse_command(command)
    respond
  rescue NoMethodError
    'Unknown command!'
  rescue NotInitializedError
    'Robot was not initialized!'
  rescue TileNotAvailable
    'Beep. The end of the map!'
  rescue WrongDirectionError
    'Wrong direction!'
  rescue ArgumentError
    'Separator should be a space'
  end

  def respond
    "Position is: #{ @position_x } | #{ @position_y }, facing: #{ @facing }"
  end

  private

  def parse_command(command)
    params = []
    @param_commands.each do |param|
      if command.include? param
        data = command.split(' ')
        fail NoMethodError unless data.length > 1
        params = data[1..-1]
        command = data.first
      end
    end
    if initialized?(command)
      send('command_' + command, *params)
    else
      fail NotInitializedError
    end
  end

  def command_move
    step = @vector[@facing]
    available = @map.tile_available?(@position_x, @position_y, step)
    fail TileNotAvailable unless available
    @position_x += step.first
    @position_y += step.last
  end

  def command_left
    change_direction(-1)
  end

  def command_right
    change_direction(1)
  end

  def change_direction(modifier)
    facing_index = @map.compass.find_index(@facing)
    len = @map.compass.length
    new_index = facing_index + modifier
    out_of_range = new_index >= len
    new_facing = out_of_range ? 0 : new_index
    @facing = @map.compass[new_facing]
  end

  def command_place(x, y, facing)
    facing = facing.to_sym
    fail WrongDirectionError unless @vector.key?(facing)
    fail TileNotAvailable unless @map.place_available?(x.to_i, y.to_i)
    @position_x = x.to_i
    @position_y = y.to_i
    @facing = facing
  end

  def initialized?(command)
    @facing || command == 'place'
  end
end

