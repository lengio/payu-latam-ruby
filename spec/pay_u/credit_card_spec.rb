require "spec_helper"

RSpec.describe PayU::CreditCard do
  before(:all) do
    stub_request(:post, /#{PayU::Customer::ENDPOINT}$/)
      .to_return(body: File.new("./spec/fixtures/responses/customer.json"))

    stub_request(:post, %r{#{PayU::Customer::ENDPOINT}/.+/creditCards})
      .to_return(body: {token: SecureRandom.uuid}.to_json)
  end

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
