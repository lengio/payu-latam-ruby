require "spec_helper"

RSpec.describe PayU::Client do
  # Example from http://developers.payulatam.com/es/web_checkout/integration.html

  it "validates signature" do
    response = PayU::Response.new(
      client: client,
      params: {
        merchant_id: "508029",
        reference: "TestPayU04",
        amount: 150.25,
        currency: "USD",
        status_code: 6,
        signature: "00286dc735bd9eaa8ae3a3a4cbb40688",
      },
    )

    expect(response.valid?).to be_truthy
  end

  it "validates signature" do
    response = PayU::Response.new(
      client: client,
      params: {
        merchant_id: "508029",
        reference: "TestPayU04",
        amount: 150.35,
        currency: "USD",
        status_code: 6,
        signature: "9df2bb60e2838170009040982967923f",
      },
    )

    expect(response.valid?).to be_truthy
  end

  it "validates signature" do
    response = PayU::Response.new(
      client: client,
      params: {
        merchant_id: "508029",
        reference: "TestPayU04",
        amount: 150.34,
        currency: "USD",
        status_code: 6,
        signature: "779f163be9347a691bcdb25064644795",
      },
    )

    expect(response.valid?).to be_truthy
  end

  private def client
    PayU::Client.new(key: "4Vj8eK4rloUd272L48hsrarnUA", merchant_id: "508029")
  end
end
