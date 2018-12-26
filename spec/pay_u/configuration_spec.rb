require "spec_helper"

RSpec.describe PayU::Configuration do
  it "configures PayU with block" do
    api_key = "12345"
    PayU.configure do |config|
      config.api_key = api_key
      config.test = true
    end

    expect(PayU.configuration.api_key).to eq(api_key)
    expect(PayU.configuration.test).to be_truthy
  end

  it "resets config" do
    PayU.reset

    expect(PayU.configuration.api_key).to be_nil
  end

  it "assigns config" do
    PayU.configuration = PayU::Configuration.new(test: true)

    expect(PayU.configuration.test).to be_truthy
  end
end
