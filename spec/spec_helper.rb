require 'rspec'

$:.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
require 'dottor'
require 'helpers/utils'

RSpec.configure do |c|
  c.include Utils

  c.mock_with :rspec

  c.before(:each) do
    STDOUT.should_receive(:puts).and_return("")
  end
end
