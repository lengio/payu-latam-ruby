class PayU::Plan
  include Virtus.model
  include PayU::Resource

  ENDPOINT = "rest/v#{PayU::API_VERSION}/plans".freeze

  attribute :account_id, Integer
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

  def self.new_from_api(params)
    plan = super(params)

    plan.code = params["planCode"]

    if params["additionalValues"]
      plan.currency = params["additionalValues"].first["currency"].to_s
      plan.data = params["additionalValues"].inject({}) do |memo, hash|
        memo.merge(hash["name"].to_s => hash["value"])
      end
    end

    plan
  end


  def to_params
    {
      accountId: account_id,
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


  def to_update_params
    {
      planCode: code,
      description: description,
      paymentAttemptsDelay: payment_attempts_delay,
      maxPendingPayments: max_pending_payments,
      maxPaymentAttempts: max_payment_attempts,
      additionalValues: data.map do |name, value|
        {name: name, value: value, currency: currency.to_s}
      end,
    }
  end


  private def identifier
    code
  end
end
