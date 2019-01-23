require "spec_helper"
require "fixtures/response"

RSpec.describe PayU::Response do
  it "creates object from callback" do
    response = PayU::Response.new(Fixtures.response)

    expect(response.order.approved?).to be_truthy
    expect(response.order.amount).to eq(Fixtures.response[:TX_VALUE].to_f)
    expect(response.order.reference_code).to eq(Fixtures.response[:referenceCode])
    expect(response.order.transaction_id).to eq(Fixtures.response[:transactionId])
    expect(response.order.response_message).to eq("APPROVED")
    expect(response.order.payment_method).to eq("VISA")
    expect(response.order.extra_1).to eq(Fixtures.response[:extra1])
    expect(response.order.extra_2).to eq(Fixtures.response[:extra2])
    expect(response.order.extra_3).to eq(Fixtures.response[:extra3])
    expect(response.valid?).to be_truthy
  end

  # Example from http://developers.payulatam.com/es/web_checkout/integration.html
  it "validates signature" do
    response = PayU::Response.new(params.merge(
                                    TX_VALUE: 150.25,
                                    signature: "00286dc735bd9eaa8ae3a3a4cbb40688",
                                  ))

    expect(response.valid?).to be_truthy
  end

  it "validates signature" do
    response = PayU::Response.new(params.merge(
                                    TX_VALUE: 150.35,
                                    signature: "9df2bb60e2838170009040982967923f",
                                  ))

    expect(response.valid?).to be_truthy
  end

  it "validates signature" do
    response = PayU::Response.new(params.merge(
                                    TX_VALUE: 150.34,
                                    signature: "779f163be9347a691bcdb25064644795",
                                  ))

    expect(response.valid?).to be_truthy
  end


  private def params
    {
      account_id: 508_028,
      referenceCode: "TestPayU04",
      currency: :USD,
      transactionState: PayU::Order::DECLINED,
    }
  end
end
