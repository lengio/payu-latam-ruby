# PayU Latam Ruby Library

## Installation

    gem build payu-latam.gemspec

## Usage

```ruby
require "pay_u"

PayU.configure do |config|
  config.api_key = "4Vj8eK4rloUd272L48hsrarnUA" # Replace with your own API key
  config.test = true # Test mode
end

client = PayU::Client.new(
  api_key: "4Vj8eK4rloUd272L48hsrarnUA",
  account_id: "512321"
)

order = PayU::Order.new(
  client: client
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
