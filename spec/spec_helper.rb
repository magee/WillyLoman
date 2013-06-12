require_relative '../graph'
require_relative '../graphdata'
require_relative '../path'
require_relative '../app'

require 'rspec'

  RSpec.configure do |config|
    config.color_enabled = true
    config.formatter     = 'documentation'
  end

