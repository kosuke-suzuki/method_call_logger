# MethodCallLogger

If you want to trace instances of some classes, you may think you'd like to log any method call of these classes.
This library provides such tracing functionality of instance method call.

This library automatically logs any instance method call with the specified logger with debug severity.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'method_call_logger'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install method_call_logger

## Usage

Set `method_call_logging` in the class you want to log.
Set logger in `@logger` instance variable in `iniitalize` for method_call_library to access it.
Don't forget to initialize `@logger` before any instance method is called.

`@logger` must have the same interface as [Ruby's standard library's logger](https://ruby-doc.org/stdlib-2.6.4/libdoc/logger/rdoc/Logger.html).

```ruby
class SampleClass
  method_call_logging

  def initialize(logger)
    @logger = logger
  end

  def sample_method
  end

  def sample_method2(arg1, arg2, arg3)
  end
end

logger = Logger.new(STDOUT)
sample_inst = SampleClass.new(logger)
sample_inst.sample_method
# D, [2019-09-19T01:25:18.518278 #2600] DEBUG -- : SampleClass#sample_method
sample_inst.sample_method2("a", 1, {b: 1})
# D, [2019-09-23T05:54:25.947357 #7911] DEBUG -- : SampleClass#sample_method2(arg1:"a", arg2:1, arg3:{:b=>1})
```
If you change the severity (loglevel) for some methods, specify it as an option to `method_call_logging`.

```ruby
class SampleClass
  method_call_logging sample_method: Logger::INFO

  def sample_method
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kosuke-suzuki/method_call_logger. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the MethodCallLogger project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/method_call_logger/blob/master/CODE_OF_CONDUCT.md).
