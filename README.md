# Sinatra::Validation
[![Gem Version](https://badge.fury.io/rb/sinatra-validation.svg)](https://badge.fury.io/rb/sinatra-validation)
[![CircleCI](https://circleci.com/gh/IzumiSy/sinatra-validation.svg?style=shield)](https://circleci.com/gh/IzumiSy/sinatra-validation)

> Sinatra extension for request parameter validation powered with dry-validation

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sinatra-validation'
```

Or install it yourself as:

    $ gem install sinatra-validation

## Usage
Register `Sinatra::Validation` to your Sinatra application.
```ruby
class Application < Sinatra::Base
  configure do
    register Sinatra::Validation
  end
end
```
Now you can use `validates` helper in your routes. The validation logic itself is implemented by [dry-validation](http://dry-rb.org/gems/dry-validation/) internally, so follow the validation syntax provided by the gem.
```ruby
  get '/basic' do
    validates do
      params do
        required("name").filled(:str?)
        required("age").filled(:str?)
      end
    end

    ...
  end
```
The helper halts with 400 if `params` does not meet the given validation rule.

### Silent
You can suppress the default behavior which `validates` helper halts with 400 when the validation fails by setting `silent` option to true. With the option, `validates` helper returns the instance of `Validation::Result`.
```ruby
  get '/silent' do
    result = validates silent: true do
      params do
        required("name").filled(:str?)
        required("age").filled(:str?)
      end
    end

    p result # <struct Sinatra::Validation::Result params={"name"=>"justine"}, messages=["age is missing"]>

    ...
  end
```
You can do `enable :silent_validation` in your Sinatra application instead if you want to enable this option to all validations.
### Raise
By default, `validates` helper halts with 400, but if you set the option `raise` to true, you can make `validates` helper raise the exception instead.
```ruby
  get '/raise' do
    begin
      validates raise: true do
        params do
          required("name").filled(:str?)
        end
      end
    rescue => e
      p e.result # <Sinatra::Validation::InvalidParameterError: {:params=>{}, :messages=>["name is missing"]}>
    end

    ...
  end
```
if you want to enable this option to all validations, you can do `enable :raise_sinatra_validation_exception` in your Sinatra application instead. Then, you can catch the exception in `error` block or something.
```ruby
  enable :raise_sinatra_validation_exception

  error Sinatra::Validation::InvalidParameterError do
    # do anything you want
  end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/IzumiSy/sinatra-validation. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

