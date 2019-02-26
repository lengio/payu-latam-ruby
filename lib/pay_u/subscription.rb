class PayU::Subscription
  include Virtus.model
  include PayU::Resource

  ENDPOINT = "rest/v#{PayU::API_VERSION}/subscriptions".freeze

  attribute :id, String
  attribute :quantity, Integer
  attribute :installments, Integer
  attribute :trial_days, Integer
  attribute :current_period_start, Time
  attribute :current_period_end, Time
  attribute :immediate_payment, Boolean
  attribute :extra_1, String
  attribute :extra_2, String
  attribute :delivery_address, Hash
  attribute :notify_url, String
  attribute :plan, PayU::Plan
  attribute :customer, PayU::Customer

  def to_params
    {
      quantity: quantity,
      installments: installments,
      trialDays: trial_days,
      immediatePayment: immediate_payment,
      extra1: extra_1,
      extra2: extra_2,
      customer: customer.to_params,
      plan: plan.to_params,
      deliveryAddress: delivery_address,
      notifyUrl: notify_url,
    }
  end


  def assign_extra_fields(response)
    self.id = response["id"]
    self.current_period_start = response["currentPeriodStart"]
    self.current_period_end = response["currentPeriodEnd"]
  end
end
