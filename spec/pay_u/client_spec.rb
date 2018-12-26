require "spec_helper"

RSpec.describe PayU::Client do
  it "creates client" do
    api_key = "12345"
    account_id = 67_890
    client = PayU::Client.new(api_key: api_key, account_id: account_id)

    expect(client.api_key).to eq(api_key)
    expect(client.account_id).to eq(account_id)
  end
end
