require "spec_helper"

RSpec.describe PayU::CreditCard do
  context "new plan" do
    it "creates subscripition" do
      subscription = PayU::Subscription.create(
        subscription_params.merge(plan: Fixtures.plan),
      )

      expect(subscription.id).not_to be_nil
    end
  end

  context "existing plan" do
    it "creates subscripition" do
      plan = PayU::Plan.create(Fixtures.plan)
      subscription = PayU::Subscription.create(subscription_params.merge(plan: {code: plan.code}))

      expect(subscription.id).not_to be_nil
    end
  end

  private def subscription_params
    {
      quantity: 1,
      installments: 1,
      trial_days: 0,
      immediate_payment: true,
      notify_url: "https://example.com",
      customer: {
        name: "Sample User Name",
        email: "sample@sample.com",
        credit_cards: credit_cards_params,
      },
    }
  end

  private def credit_cards_params
    [Fixtures.credit_card]
  end
end
