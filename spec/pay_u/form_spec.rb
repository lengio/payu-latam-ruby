require "spec_helper"

RSpec.describe PayU::Form do
  # Example from http://developers.payulatam.com/es/web_checkout/integration.html

  it "validates signature" do
    response = PayU::Form.new(
      client: client,
      merchant_id: "508029",
      reference_code: "TestPayU",
      amount: 20_000,
      currency: "COP",
    )

    expect(response.signature).to eq("7ee7cf808ce6a39b17481c54f2c57acc")
  end

  private def client
    PayU::Client.new(api_key: "4Vj8eK4rloUd272L48hsrarnUA", account_id: "508028")
  end
end
