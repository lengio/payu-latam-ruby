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
  config.account_ids = {
    AR: 512_322,
    BR: 512_327,
    CL: 512_325,
    CO: 512_321,
    MX: 512_324,
    PA: 512_326,
    PE: 512_323,
  }
end

order = PayU::Order.new(
  amount: 20_000,
  currency: :COP,
  description: "Test PAYU",
)

# Form params for WebCheckout
order.form.params
```

## Resources

### Order

The base object to build a transaction.

```ruby
#<PayU::Order:0x007f95818e5c10
 @account_id=nil,
 @amount=0.3e1,
 @cc_number="************0086",
 @currency=:USD,
 @description=nil,
 @email="test@test.com",
 @extra_1="extra 1",
 @extra_2="extra 2",
 @extra_3="extra 3",
 @payment_method="VISA",
 @payment_method_code=2,
 @reference_code="2205229",
 @response_code=1,
 @response_message="APPROVED",
 @status_code=4,
 @tax=nil,
 @tax_return_base=nil,
 @transaction_id="957aa79c-135d-413e-b7fc-aaaa0000cccc">
 
order.form # Form object
order.approved? # Transaction was approved
order.declined? # Transaction was declined
order.error? # Transaction failed
order.pending? # Transaction is pending
order.expired? # Transaction expired
```

### Confirmation

A confirmation object from the confirmation Webhook (POST when transaction is finalized)

```ruby
#<PayU::Confirmation:0x007f95818e5cb0
 @order=#<PayU::Order:0x007f95818e5c10…> # Order object
 @signature="cc3c8101113b056bc4b5b3d289dbb106", # Signature to verify
 @signer=#<PayU::Signer::Confirmation:0x007f95822e3b40…>> # Signer to verify signature
 
confirmation.valid? # Signature is valid
```

### Response

A response object from the response Webhook (GET when the user leaves the payment page and is sent back to the commerce)

```ruby
#<PayU::Order:0x007f8a33bf7e48
 @order=#<PayU::Order:0x007f8a33bf7e48…> # Order object
 @signature="cc3c8101113b056bc4b5b3d289dbb106", # Signature to verify
 @signer=#<PayU::Signer::Response:0x007f8a33bdf9d8…>> # Signer to verify signature
 
order.valid? # Signature is valid
```

### Customer

```ruby
PayU::Customer.create(
  name: "Sample User Name",
  email: "sample@sample.com",
)
```

### Credit card

```ruby
PayU::CreditCard.create(
  name: "Sample User Name",
  document: "1020304050",
  number: "4242424242424242",
  exp_month: 12,
  exp_year: 20,
  type: "VISA",
  customer_id: 4ef04ef0aaaa,
)
```

### Plan

```ruby
PayU::Plan.create(
  account_id: 512_321,
  code: SecureRandom.hex(8),
  description: "Plan",
  interval: "MONTH",
  interval_count: 1,
  max_payments_allowed: 12,
  payment_attempts_delay: 1,
  data: {PLAN_VALUE: 20_000, PLAN_TAX: 0, PLAN_TAX_RETURN_BASE: 0},
  currency: :COP,
)
```

### Subscription

Subscription object that ties a customer, a plan, and a credit card.

```ruby
#<PayU::Subscription:0x007fe0de8e4790
 @current_period_end=2019-03-26 23:59:59 -0500,
 @current_period_start=2019-02-27 00:00:00 -0500,
 @customer=
  #<PayU::Customer:0x007fe0de8d43e0
   @credit_cards=
    [#<PayU::CreditCard:0x007fe0de8ce288
      @address={},
      @customer_id=nil,
      @document=nil,
      @exp_month=nil,
      @exp_year=nil,
      @name=nil,
      @number=nil,
      @token="db092e5e-65aa-48c6-92b1-aaaa0000cccc",
      @type=nil>],
   @email="sample@sample.com",
   @id="4ef04ef0aaaa",
   @name="Sample User Name">,
 @delivery_address={},
 @extra_1=nil,
 @extra_2=nil,
 @id="44f09r1p5561",
 @immediate_payment=true,
 @installments=1,
 @notify_url="https://example.com",
 @plan=
  #<PayU::Plan:0x007fe0de8d7a68
   @account_id=512321,
   @code="4689fe81dd927aae",
   @currency=:COP,
   @data={"PLAN_TAX_RETURN_BASE"=>0, "PLAN_TAX"=>0, "PLAN_VALUE"=>20000},
   @description="Plan",
   @id="6da3e0b5-cfb6-430d-93ef-aaaa0000cccc",
   @interval=:MONTH,
   @interval_count=1,
   @max_payment_attempts=nil,
   @max_payments_allowed=nil,
   @max_pending_payments=nil,
   @payment_attempts_delay=nil,
   @trial_days=nil>,
 @quantity=1,
 @trial_days=nil>
```


## Sandbox

- Sandbox endpoint
- Test mode in your account
- Test param in params

## Testing

    rspec

## Console

    bin/console
