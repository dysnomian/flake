# Flake
[![Build Status](https://travis-ci.org/dysnomian/flake.svg?branch=master)](https://travis-ci.org/dysnomian/flake)
[![Code Climate](https://codeclimate.com/github/dysnomian/flake/badges/gpa.svg)](https://codeclimate.com/github/dysnomian/flake)
[![Security](https://hakiri.io/github/dysnomian/flake/master.svg)](https://hakiri.io/github/dysnomian/flake/master)
[![Inline Docs](http://inch-ci.org/github/dysnomian/flake.svg?branch=master)](http://inch-ci.org/github/dysnomian/flake)

Simulate your flaky methods deterministically.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'flake'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install flake

## Usage

For Minitest:

```ruby
setup do
  Flake.on(HyperdriveMotivator, :activate_jump, AlluvialDamperError)
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/flake. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
