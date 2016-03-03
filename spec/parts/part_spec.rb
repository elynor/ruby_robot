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

  it 'should load commands in array' do
    expect(@part.commands).not_to be_empty
    expect(@part.commands).to be_instance_of(Array)
  end

  it 'should load proper default commands' do
    expect(@part.commands).to include('status')
  end

  it 'should not duplicate commands' do
    expect(@part.commands).to eq(@part.commands.uniq)
  end
end