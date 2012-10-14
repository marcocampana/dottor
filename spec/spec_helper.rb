require 'rspec'

$:.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
require 'dottor'
require 'helpers/utils'
require 'fakefs/spec_helpers'

RSpec.configure do |c|
  c.include Utils

  c.mock_with :rspec

  c.include FakeFS::SpecHelpers, fakefs: true

  c.before(:each) do
    # STDOUT.should_receive(:puts).at_least(1).times.and_return("")
  end

  def capture(stream)
    begin
      stream = stream.to_s
      eval "$#{stream} = StringIO.new"
      yield
      result = eval("$#{stream}").string
    ensure
      eval("$#{stream} = #{stream.upcase}")
    end

    result
  end
end
