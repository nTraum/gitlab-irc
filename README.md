## gitlab-irc

[![Build Status](https://travis-ci.org/nTraum/gitlab-irc.png?branch=master)](https://travis-ci.org/nTraum/gitlab-irc)

Tiny web / IRC application that announces commits for GitLab repositories via IRC.
Built with Sinatra and cinch. Uses GitLab's web hooks, no voodoo required.

Example message:

> [gitlab-irc(master)] nTraum | initial commit | [http://goo.gl/yYTGcM](http://goo.gl/yYTGcM)

### Requirements

* Redis (already installed if you run it on the same host as GitLab)
* Ruby 1.9.3 or newer
* (tmux / screen / nohup)

### Installation & Usage

1. Clone the repository: `git clone https://github.com/nTraum/gitlab-irc.git`
2. Install required gems: `cd gitlab-irc; gem install bundler; bundle`
2. Edit `config/config.yml` to your needs (e.g. IRC channel and server)
3. Start the app: `foreman start` in a tmux / screen shell
4. Add a web hook pointing to the app: `http://localhost:4567/commit` (host / port may differ, depending on your configuration)

### License

gitlab-irc is released under the [MIT License](http://opensource.org/licenses/MIT).
