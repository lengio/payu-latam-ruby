require "spec_helper"

RSpec.describe PayU::Configuration do
  let(:default_api_key) { "4Vj8eK4rloUd272L48hsrarnUA" }

  after do
    PayU.reset
  end

  it "assigns defaults" do
    expect(PayU.configuration.api_key).to eq(default_api_key)
    expect(PayU.configuration.test).to be_truthy
  end

  it "configures PayU with block" do
    api_key = "12345"
    PayU.configure do |config|
      config.api_key = api_key
      config.test = false
    end

    expect(PayU.configuration.api_key).to eq(api_key)
    expect(PayU.configuration.test).to be_falsy
  end

  it "resets config" do
    PayU.reset

    expect(PayU.configuration.api_key).to eq(default_api_key)
  end

  it "assigns config" do
    PayU.configuration = PayU::Configuration.new(test: false)

    expect(PayU.configuration.test).to be_falsy
  end
end
