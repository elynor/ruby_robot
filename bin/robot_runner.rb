require_relative '../lib/robot'

QUIT_COMMAND = 'quit'

game_map = Map.new(5, 5)
game_robot = Robot.new(game_map)

p 'Enter the command please!'
while line = gets.chomp.downcase
  break if line == QUIT_COMMAND
  p game_robot.send_command(line)
end
