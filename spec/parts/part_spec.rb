require 'rspec'
require_relative '../../spec/spec_helper'
require_relative '../../lib/parts/part'

describe Part do
  before :all do
    @part = Part.new
  end

  it 'should parse class name' do
    expect(@part.name).to eq('part')
  end

  it 'should load config' do
    expect(@part.config).not_to be_empty
  end

  it 'should load actions in array' do
    expect(@part.actions).not_to be_empty
    expect(@part.actions).to be_instance_of(Array)
  end

  it 'should load proper default actions' do
    expect(@part.actions).to include('status')
  end

  it 'should not duplicate actions' do
    expect(@part.actions).to eq(@part.actions.uniq)
  end

  it 'should raise an error if action is not in list' do
    action = 'unknown action'

    expect { @part.perform(action) }.to raise_error { |error|
      expect(error).to be_a(PartActionError)
    }
  end

  it 'should raise an error if action is empty' do
    action = '   '

    expect { @part.perform(action) }.to raise_error { |error|
      expect(error).to be_a(PartActionError)
    }
  end

  it 'should give status report on status action' do
    action = 'status'

    expect(@part.execute(action)).to eq('OK')
  end
end