require "spec_helper"

RSpec.describe PayU::Confirmation do
  # Example from http://developers.payulatam.com/es/web_checkout/integration.html

  it "validates signature" do
    response = PayU::Confirmation.new(params.merge(
                                        reference_code: "TestPayU04",
                                        amount: 150.00,
                                        status_code: 6,
                                        signature: "df67936f918887b2aa31688a77a10fe1",
                                      ))

    expect(response.valid?).to be_truthy
  end

  it "validates signature" do
    response = PayU::Confirmation.new(params.merge(
                                        reference_code: "TestPayU05",
                                        amount: 150.26,
                                        status_code: 4,
                                        signature: "1d95778a651e11a0ab93c2169a519cd6",
                                      ))

    expect(response.valid?).to be_truthy
  end

  private def client
    PayU::Client.new(api_key: "4Vj8eK4rloUd272L48hsrarnUA", account_id: "508028")
  end

  private def params
    {
      client: client,
      merchant_id: "508029",
      currency: "USD",
      status_code: 6,
    }
  end
end
