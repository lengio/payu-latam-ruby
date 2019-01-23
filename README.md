# PayU Latam Ruby Library

[![CircleCI](https://circleci.com/gh/lengio/payu-latam-ruby.svg?style=svg)](https://circleci.com/gh/lengio/payu-latam-ruby)
[![Coverage Status](https://coveralls.io/repos/github/lengio/payu-latam-ruby/badge.svg?branch=master)](https://coveralls.io/github/lengio/payu-latam-ruby?branch=master)
[![Maintainability](https://api.codeclimate.com/v1/badges/28162c8ec3dfe0ec4227/maintainability)](https://codeclimate.com/github/lengio/payu-latam-ruby/maintainability)

## Installation

    gem "payu-latam", github: "lengio/payu-latam-ruby", require: "pay_u"

    # Local
    gem build payu-latam.gemspec

## Usage

```ruby
require "pay_u"

PayU.configure do |config|
  config.api_key = "4Vj8eK4rloUd272L48hsrarnUA" # Replace with your own API key
  config.merchant_id = 508_029 # Replace with your own merchant ID
  config.test = true # Test mode
end

order = PayU::Order.new(
  amount: 20_000,
  currency: :COP,
  description: "Test PAYU"
)

order.form.params
```

## Sandbox

- Sandbox endpoint
- Test mode in your account
- Test param in params

## Testing

    rspec

## Console

    bin/console
