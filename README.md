# PayU Latam Ruby Library

[![CircleCI](https://circleci.com/gh/lengio/payu-latam-ruby.svg?style=svg)](https://circleci.com/gh/lengio/payu-latam-ruby)
[![Coverage Status](https://coveralls.io/repos/github/lengio/payu-latam-ruby/badge.svg?branch=master)](https://coveralls.io/github/lengio/payu-latam-ruby?branch=master)

## Installation

    gem build payu-latam.gemspec

## Usage

```ruby
require "pay_u"

PayU.configure do |config|
  config.api_key = "4Vj8eK4rloUd272L48hsrarnUA" # Replace with your own API key
  config.merchant_id = 508029 # Replace with your own merchant ID
  config.test = true # Test mode
end

order = PayU::Order.new(
  amount: 20_000,
  currency: :COP,
  description: "Test PAYU"
)

order.form.params
```

## Testing

    rspec

## Console

    bin/console
