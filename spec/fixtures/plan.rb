module Fixtures
  def self.plan
    {
      account_id: 512_321,
      code: SecureRandom.hex(8),
      description: "Plan",
      interval: "MONTH",
      interval_count: 1,
      max_payments_allowed: 12,
      payment_attempts_delay: 1,
      data: {PLAN_VALUE: 20_000, PLAN_TAX: 0, PLAN_TAX_RETURN_BASE: 0},
      currency: :COP,
    }
  end
end
