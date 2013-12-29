require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require 'minitest/reporters'
require File.expand_path('../../lib/gitlab-irc.rb', __FILE__)

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new