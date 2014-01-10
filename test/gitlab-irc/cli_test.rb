require_relative '../test_helper'

describe Cli do
  describe 'version flag' do
    it 'recognizes the short style switch' do
      proc { Cli.new ['-v'] }.must_output /^gitlab-irc \d+(\.\d+)*$/
    end
    it 'recognizes the long style switch' do
      proc { Cli.new ['--version'] }.must_output /^gitlab-irc \d+(\.\d+)*$/
    end
  end
end