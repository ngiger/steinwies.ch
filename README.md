# steinwies.ch

[steinwies.ch](http://steinwies.ch/)

## Setup

### Requirements

* Ruby, `>= 2.3.1`
* Apache2
* [mod_ruby](https://github.com/shugo/mod_ruby) (It works with Ruby `1.8.6`)
* cronolog (optional)
* daemontools (for davazd, yusd)

### Install

```zsh
: Ruby and Rubygems
: check your ruby version
% ruby --version
ruby 2.3.1p112 (2016-04-26 revision 54768) [x86_64-linux]

% echo 'gem: --no-ri --no-rdoc' > ~/.gemrc

% cd /path/to/steinwies.ch
% bundle install --path vendor
```

### Configuration

Use sample files in `etc` directory.

```zsh
: Application conf (edit for your credentials)
% cp etc/config.yml.sample etc/config.yml

: Apache2 conf
% cp etc/steinwies.ch.conf.sample /etc/apache2/vhosts.d/steinwies.ch.conf
```

And then, boot application server as `bundle exec ./bin/steinwies`.

## Test

### Dependencies

* Ruby
* Node.js

* [minitest](https://github.com/seattlerb/minitest)
* [Selenium](http://docs.seleniumhq.org/) (via [watir](https://github.com/watir/watir))
* [PhantomJS](https://github.com/ariya/phantomjs)

### Setup

```zsh
% git clone https://github.com/zdavatz/steinwies.ch.git
% cd steinwies.ch

: e.g. use nodeenv
% pip install nodeenv
% nodeenv --node=0.12.15 env
% source env/bin/activate

: install phantomjs
(env) % npm install

(env) % bundle install
```

### How to run

#### Test suite

```zsh
% bundle exec rake test
```

#### Single feature test

```zsh
: `DEBUG=true` is useful for debug (but it might be not interested)
bundle exec foreman run ruby -I.:test test/feature/home_test.rb
Run options: --seed 33427

# Running:

**

Fabulous run in 3.490279s, 0.5730 runs/s, 3.7246 assertions/s.

2 runs, 13 assertions, 0 failures, 0 errors, 0 skips
```

## License

Copyright (C) 2006-2016 ywesee GmbH.

This is free software;
You can redistribute it and/or modify it under the terms of the GNU General Public License (GPL v3.0).

See `LICENSE`.
