require "spec_helper"

RSpec.describe PayU::CreditCard do
  before do
    stub_subscription_request

    stub_plan_request
  end

  context "new plan" do
    it "creates subscripition" do
      plan_params = Fixtures.plan
      subscription = PayU::Subscription.create(
        subscription_params.merge(plan: plan_params),
      )

      expect(subscription.id).not_to be_nil
      expect(subscription.customer.name).to eq(customer_params[:name])
      expect(subscription.customer.email).to eq(customer_params[:email])
      expect(subscription.plan.code).to eq(plan_params[:code])
    end
  end

  context "existing plan" do
    it "creates subscripition" do
      plan = PayU::Plan.create(Fixtures.plan)
      subscription = PayU::Subscription.create(subscription_params.merge(plan: {code: plan.code}))

      expect(subscription.id).not_to be_nil
      expect(subscription.customer.name).to eq(customer_params[:name])
      expect(subscription.customer.email).to eq(customer_params[:email])
      expect(subscription.plan.code).to eq(plan.code)
    end
  end

  private def subscription_params
    {
      quantity: 1,
      installments: 1,
      trial_days: 0,
      immediate_payment: true,
      notify_url: "https://example.com",
      customer: customer_params,
    }
  end

  private def customer_params
    {
      name: "Sample User Name",
      email: "sample@sample.com",
      credit_cards: credit_cards_params,
    }
  end

  private def credit_cards_params
    [Fixtures.credit_card]
  end
end
