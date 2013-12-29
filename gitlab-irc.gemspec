# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gitlab-irc/version'

Gem::Specification.new do |spec|
  spec.name                   = 'gitlab-irc'
  spec.version                = GitlabIrc::VERSION
  spec.author                 = 'Philipp Preß'
  spec.email                  = 'philipp.press@googlemail.com'
  spec.summary                = 'Tiny web / IRC application that announces commits for GitLab repositories via IRC.'
  spec.description            = 'gitlab-irc takes Gitlab\'s web hooks and announces pushed commits in an IRC channel.'
  spec.homepage               = 'https://github.com/nTraum/gitlab-irc'
  spec.license                = 'MIT'
  spec.post_install_message   = 'Thanks for installing!'
  spec.required_ruby_version  = '>= 1.9.2'
  spec.requirements           = 'Redis Database'

  spec.files          = `git ls-files`.split($/)
  spec.executables    = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files     = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths  = ['lib']

  spec.add_development_dependency 'yard',               '~> 0.8'
  spec.add_development_dependency 'bundler',            '~> 1.3'
  spec.add_development_dependency 'minitest',           '~> 5.2'
  spec.add_development_dependency 'minitest-reporters', '~> 1.0'
  spec.add_development_dependency 'rake'

  spec.add_runtime_dependency 'cinch',        '~> 2.0'
  spec.add_runtime_dependency 'foreman',      '~> 0.63'
  spec.add_runtime_dependency 'googl',        '~> 0.6'
  spec.add_runtime_dependency 'multi_json',   '~> 1.8'
  spec.add_runtime_dependency 'redis',        '~> 3.0'
  spec.add_runtime_dependency 'sinatra',      '~> 1.4'
end
