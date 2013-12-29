## gitlab-irc

[![Build Status](https://travis-ci.org/nTraum/gitlab-irc.png?branch=gemify)](https://travis-ci.org/nTraum/gitlab-irc) [![Dependency Status](https://gemnasium.com/nTraum/gitlab-irc.png)](https://gemnasium.com/nTraum/gitlab-irc)

Tiny web / IRC application that announces commits for GitLab repositories via IRC.
Built with Sinatra and cinch. Uses GitLab's web hooks, no voodoo required.

Example message:

> [gitlab-irc(master)] nTraum | initial commit | [http://goo.gl/yYTGcM](http://goo.gl/yYTGcM)

### Requirements

* Redis (already installed if you run it on the same host as GitLab)
* Ruby 2.0 (older versions may work as well)
* tmux / screen

### Installation & Usage

1. Install the gem: `gem install gitlab-irc`
2. Edit `config/config.yml` to your needs (e.g. IRC channel and server)
3. Start the app: `foreman start` in a tmux / screen shell
4. Add a web hook pointing to the app: `http://localhost/commit:4567` (host / port may differ, depending on your configuration)

### License

gitlab-irc is released under the [MIT License](http://opensource.org/licenses/MIT).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request