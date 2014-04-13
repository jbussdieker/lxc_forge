# LXC Forge

[![Gem Version](https://badge.fury.io/rb/lxc_forge.svg)](http://badge.fury.io/rb/lxc_forge)
[![Build Status](https://travis-ci.org/jbussdieker/lxc_forge.svg?branch=master)](https://travis-ci.org/jbussdieker/lxc_forge)
[![Dependency Status](https://gemnasium.com/jbussdieker/lxc_forge.svg)](https://gemnasium.com/jbussdieker/lxc_forge)
[![Code Climate](https://codeclimate.com/github/jbussdieker/lxc_forge.png)](https://codeclimate.com/github/jbussdieker/lxc_forge)
[![Coverage Status](https://coveralls.io/repos/jbussdieker/lxc_forge/badge.png)](https://coveralls.io/r/jbussdieker/lxc_forge)

Upload and download LXC containers from S3

## Installation

Install the gem:

    $ gem install lxc_forge

Configure the settings:

    $ lxc-forge --configure

## Usage

Upload a container to S3:

    $ lxc-forge upload -n mycontainer

Download a container from S3:

    $ lxc-forge download -n mycontainer

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
