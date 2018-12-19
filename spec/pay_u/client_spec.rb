require "spec_helper"

RSpec.describe PayU::Client do
  it "creates client" do
    key = "12345"
    merchant_id = "67890"
    client = PayU::Client.new(key: key, merchant_id: merchant_id)

    expect(client.key).to eq(key)
    expect(client.merchant_id).to eq(merchant_id)
  end
end
