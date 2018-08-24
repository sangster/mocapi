# Mocapi

[![Gem Version](https://badge.fury.io/rb/mocapi.svg)](https://badge.fury.io/rb/mocapi)
[![Maintainability](https://api.codeclimate.com/v1/badges/e5ff3fe936709bf32593/maintainability)](https://codeclimate.com/github/sangster/mocapi/maintainability)
[![GitHub license](https://img.shields.io/github/license/sangster/mocapi.svg)](https://github.com/sangster/mocapi/blob/master/LICENSE.txt)


`mocapi` is a simple HTTPd application server which calculates mortgage payment
given schedule and financial details provided by end users.

## Installation

```sh
gem install mocapi
```

## Example Usage

```sh
```

## Development

### Testing

A few Rake commands will help your testing:

  - `rake test`: Run the test suite
  - `rake lint`: Run the code linters
  - `rake simplecov`: Run the code coverage reporter
  - `rake`: Run all tests, linters, and code coverage reporters

To facilitate development, consider running `guard` in the background while you
work. Whenver a source file it changed, it will automatically run the relevent
tests. This will provide you immediate test feedback at all times.

### Documentation

Generate code docs with:

```sh
rake doc
```

### Contributing to Mocapi

  * Check out the latest master to make sure the feature hasn't been
    implemented or the bug hasn't been fixed yet.
  * Check out the issue tracker to make sure someone already hasn't requested
    it and/or contributed it.
  * Fork the project.
  * Start a feature/bugfix branch.
  * Commit and push until you are happy with your contribution.
  * Make sure to add tests for it. This is important so I don't break it in a
    future version unintentionally.
  * Please try not to mess with the Rakefile, version, or history. If you want
    to have your own version, or is otherwise necessary, that is fine, but
    please isolate to its own commit so I can cherry-pick around it.
