require 'rspec'
require_relative '../../spec/spec_helper'
require_relative '../../lib/parts/command_interface'

describe CommandInterface do
  before :all do
    @interface = CommandInterface.new
  end

  it 'should accept text command' do
    command = 'status'
    expect { @interface.send_command(command) }.not_to raise_error
  end

  it 'should raise an error on unknown command' do
    command = 'do something'
    expect { @interface.send_command(command) }.to raise_error { |error|
      expect(error).to be_a(CommandInputError)
    }
  end

  it 'should raise an error on empty command' do
    command = '   '
    expect { @interface.send_command(command) }.to raise_error { |error|
      expect(error).to be_a(CommandInputError)
    }
  end

  it 'should raise an error on nil command' do
    command = nil
    expect { @interface.send_command(command) }.to raise_error { |error|
      expect(error).to be_a(CommandInputError)
    }
  end

  it 'should accept command to check devices' do
    expect(@interface.commands).to include 'parts_list'
  end
end
