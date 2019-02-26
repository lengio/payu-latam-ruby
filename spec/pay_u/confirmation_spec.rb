require "spec_helper"

RSpec.describe PayU::Confirmation do
  it "creates object from callback" do
    confirmation = PayU::Confirmation.new(Fixtures.confirmation)

    expect(confirmation.order.approved?).to be_truthy
    expect(confirmation.order.amount).to eq(Fixtures.confirmation[:value].to_f)
    expect(confirmation.order.reference_code).to eq(Fixtures.confirmation[:reference_sale])
    expect(confirmation.order.transaction_id).to eq(Fixtures.confirmation[:transaction_id])
    expect(confirmation.order.response_message).to eq("APPROVED")
    expect(confirmation.order.payment_method).to eq("VISA")
    expect(confirmation.order.extra_1).to eq(Fixtures.confirmation[:extra1])
    expect(confirmation.order.extra_2).to eq(Fixtures.confirmation[:extra2])
    expect(confirmation.order.extra_3).to eq(Fixtures.confirmation[:extra3])
    expect(confirmation.valid?).to be_truthy
  end

  # Example from http://developers.payulatam.com/es/web_checkout/integration.html
  it "validates signature" do
    confirmation = PayU::Confirmation.new(params.merge(
                                            reference_sale: "TestPayU04",
                                            value: "150.00",
                                            state_pol: PayU::Order::DECLINED,
                                            sign: "df67936f918887b2aa31688a77a10fe1",
                                          ))

    expect(confirmation.valid?).to be_truthy
  end

  it "validates signature" do
    confirmation = PayU::Confirmation.new(params.merge(
                                            reference_sale: "TestPayU05",
                                            value: "150.26",
                                            state_pol: PayU::Order::APPROVED,
                                            sign: "1d95778a651e11a0ab93c2169a519cd6",
                                          ))

    expect(confirmation.valid?).to be_truthy
  end

  private def params
    {
      account_id: 508_028,
      currency: :USD,
    }
  end
end
