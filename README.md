# LXC Forge

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

    $ lxc-forge download -o mycontainer

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
