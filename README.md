# steinwies.ch

* [steinwies.ch](http://steinwies.ch/)
* https://github.com/zdavatz/steinwies.ch (source)

## Setup

### Requirements

* Ruby, `>= 2.3.1`
* Apache2 with a ProxyPass
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

`bundle exec rake test`

#### Single feature test

`bundle exec test/feature/kontakt_test.rb --name test_kontakt_submit_kontakt`


### Running:

You must start the DRB server process and the Rack-Webserver in two seperate threads using

* `bundle exec bin/steinwies`
* `bundle exec rackup`

```
## Open problems

* Submitting the form does not work see test_kontakt_submit_kontakt
* Combine logging of apache and running Ruby processes?

## License

Copyright (C) 2006-2016 ywesee GmbH.

This is free software;
You can redistribute it and/or modify it under the terms of the GNU General Public License (GPL v3.0).

See `LICENSE`.
