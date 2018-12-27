require "spec_helper"

RSpec.describe PayU::Confirmation do
  # Example from http://developers.payulatam.com/es/web_checkout/integration.html
  it "validates signature" do
    confirmation = PayU::Confirmation.new(params.merge(
                                            reference_code: "TestPayU04",
                                            amount: 150.00,
                                            status_code: PayU::Order::DECLINED,
                                            signature: "df67936f918887b2aa31688a77a10fe1",
                                          ))

    expect(confirmation.valid?).to be_truthy
  end

  it "validates signature" do
    confirmation = PayU::Confirmation.new(params.merge(
                                            reference_code: "TestPayU05",
                                            amount: 150.26,
                                            status_code: PayU::Order::APPROVED,
                                            signature: "1d95778a651e11a0ab93c2169a519cd6",
                                          ))

    expect(confirmation.valid?).to be_truthy
  end


  private def params
    {
      account_id: 508_028,
      currency: :USD,
      status_code: 6,
    }
  end
end
