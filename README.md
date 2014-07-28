# Apitools::Middleware [![Build Status](https://travis-ci.org/APItools/apitools-middleware.svg?branch=master)](https://travis-ci.org/APItools/apitools-middleware)

Ruby Library for working with APItools Middleware. Validating, testing, ...


## Installation

Add this line to your application's Gemfile:

    gem 'apitools-middleware'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install apitools-middleware

## Usage

```ruby
repository = Apitools::Middleware::LocalRepository.new
repository.middleware.each do |middleware|
  puts "Middleware #{middleware.name} is invalid" unless middleware.valid?
end
```

## Contributing

1. Fork it ( https://github.com/APItools/apitools-middleware/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
