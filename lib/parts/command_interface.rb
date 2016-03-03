require_relative '../../lib/exceptions/command_input_error'
require_relative 'part'

class CommandInterface < Part

  def initialize
    super
  end

  def send_command(command)
    @command = command
    validate_command
  end

  private
  def validate_command
    fail CommandInputError, 'Command Nil' if @command.nil?
    fail CommandInputError, 'Command Empty' if @command.empty?
    fail CommandInputError, 'Command Not Exist' unless @actions.include? @command
  end
end
