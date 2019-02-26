class PayU::Plan
  include Virtus.model
  include PayU::Resource

  ENDPOINT = "rest/v#{PayU::API_VERSION}/plans".freeze

  attribute :id, String
  attribute :code, String
  attribute :description, String
  attribute :interval, Symbol
  attribute :interval_count, Integer
  attribute :max_payments_allowed, Integer
  attribute :max_payment_attempts, Integer
  attribute :payment_attempts_delay, Integer
  attribute :max_pending_payments, Integer
  attribute :trial_days, Integer
  attribute :data, Hash
  attribute :currency, Symbol

  def to_params
    {
      accountId: "512321",
      planCode: code,
      description: description,
      interval: interval,
      intervalCount: interval_count,
      maxPaymentsAllowed: max_payments_allowed,
      paymentAttemptsDelay: payment_attempts_delay,
      additionalValues: data.map do |name, value|
        {name: name, value: value, currency: currency.to_s}
      end,
    }
  end


  def assign_extra_fields(response)
    self.id = response["id"]
    self.max_payment_attempts = response["maxPaymentAttempts"]
    self.max_pending_payments = response["maxPendingPayments"]
    self.trial_days = response["trialDays"]
  end


  def identifier
    code
  end
end
