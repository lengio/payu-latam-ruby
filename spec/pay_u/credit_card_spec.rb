require "spec_helper"

RSpec.describe PayU::CreditCard do
  it "creates credit card token" do
    customer = PayU::Customer.create(
      name: "Sample User Name",
      email: "sample@sample.com",
    )
    credit_card = PayU::CreditCard.create(Fixtures.credit_card.merge(customer_id: customer.id))

    expect(credit_card.token).to(
      match(/\b[0-9a-f]{8}\b-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-\b[0-9a-f]{12}\b/),
    )
  end
end
