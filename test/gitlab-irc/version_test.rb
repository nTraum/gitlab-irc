require_relative '../test_helper'

describe GitlabIrc do
  it 'must have the correct version' do
    GitlabIrc::VERSION.must_equal '0.1', 'wrong gem version'
  end
end