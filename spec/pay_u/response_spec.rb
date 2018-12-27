require "spec_helper"

RSpec.describe PayU::Response do
  before do
    PayU.configure do |config|
      config.api_key = "4Vj8eK4rloUd272L48hsrarnUA"
      config.merchant_id = 508_029
    end
  end

  # Example from http://developers.payulatam.com/es/web_checkout/integration.html
  it "validates signature" do
    response = PayU::Response.new(params.merge(
                                    amount: 150.25,
                                    signature: "00286dc735bd9eaa8ae3a3a4cbb40688",
                                  ))

    expect(response.valid?).to be_truthy
  end

  it "validates signature" do
    response = PayU::Response.new(params.merge(
                                    amount: 150.35,
                                    signature: "9df2bb60e2838170009040982967923f",
                                  ))

    expect(response.valid?).to be_truthy
  end

  it "validates signature" do
    response = PayU::Response.new(params.merge(
                                    amount: 150.34,
                                    signature: "779f163be9347a691bcdb25064644795",
                                  ))

    expect(response.valid?).to be_truthy
  end


  private def params
    {
      account_id: 508_028,
      reference_code: "TestPayU04",
      currency: :USD,
      status_code: PayU::Order::DECLINED,
    }
  end
end
