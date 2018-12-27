# PayU Latam Ruby Library

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
