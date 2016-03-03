require 'yaml'

class Part

  attr_reader :name, :config, :actions

  def initialize
    @actions = initialize_basic_actions
    @name = underscore(self.class.name)
    @config = load_config_file @name
    @actions = @actions | @config['actions']
  end

  protected

  def initialize_basic_actions
    part_name = 'part'
    config = load_config_file part_name
    config['actions']
  end

  def load_config_file(part_name)
    YAML.load_file(File.join(__dir__, "config/#{ part_name }.yml"))
  end

  def underscore(word)
    word.gsub!(/::/, '/')
    word.gsub!(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
    word.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
    word.tr!("-", "_")
    word.downcase!
    word
  end
end