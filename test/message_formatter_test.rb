require './test/test_helper'
require './lib/message_formatter'

describe MessageFormatter do
  def setup
    MessageFormatter.stub :short_url, 'http://goo.gl/abcdefg' do
      @messages = MessageFormatter.messages(IO.read('test/support/commit.json'))
    end
  end

  it 'must return the correct number of messages' do
    @messages.size.must_equal 2, 'wrong number of returned messages'
  end

  it 'must contain the correct repo name' do
    @messages.each { |msg| msg.include?('Diaspora').must_equal true, 'Wrong repo name' }
  end

  it 'must contain the correct git branch' do
    @messages.each { |msg| msg.include?('(master)').must_equal true, 'wrong git branch' }
  end

  it 'must contain short urls' do
    @messages.each { |msg|  msg.end_with?('http://goo.gl/abcdefg').must_equal true }
  end

  it 'must contain the correct authors' do
    @messages[0].include?('Jordi Mallach').must_equal true, 'Wrong author for commit #1'
    @messages[1].include?('GitLab dev user').must_equal true, 'Wrong author for commit #2'
  end

  it 'must contain the correct commit message' do
    @messages[0].include?('Update Catalan translation to e38cb41.').must_equal true, 'Wrong ci message for commit #1'
    @messages[1].include?('fixed readme').must_equal true, 'Wrong ci message for commit #2'
  end
end