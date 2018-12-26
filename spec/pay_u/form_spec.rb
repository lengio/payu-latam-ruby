require "spec_helper"

RSpec.describe PayU::Form do
  # Example from http://developers.payulatam.com/es/web_checkout/integration.html

  it "validates signature" do
    order = PayU::Order.new(
      client: client,
      merchant_id: "508029",
      reference_code: "TestPayU",
      amount: 20_000,
      currency: :COP,
    )

    expect(order.form.signature).to eq("7ee7cf808ce6a39b17481c54f2c57acc")
  end

  it "generates params" do
    response_url = "http://www.test.com/response"
    confirmation_url = "http://www.test.com/confirmation"
    merchant_id = 508_029
    description = "Test PAYU"
    amount = 20_000
    currency = :COP
    PayU.configure do |config|
      config.test = true
      config.response_url = response_url
      config.confirmation_url = confirmation_url
    end
    form = PayU::Order.new(
      client: client,
      merchant_id: merchant_id,
      description: description,
      reference_code: "TestPayU",
      amount: amount,
      currency: currency,
      tax: 3_193,
      tax_return_base: 16_806,
    ).form

    expect(form.params).to be_a(Hash)
    expect(form.params[:action]).to eq(
      "https://sandbox.checkout.payulatam.com/ppp-web-gateway-payu/",
    )
    expect(form.params[:fields][:merchantId]).to eq(merchant_id)
    expect(form.params[:fields][:accountId]).to eq(client.account_id)
    expect(form.params[:fields][:description]).to eq(description)
    expect(form.params[:fields][:amount]).to eq(amount)
    expect(form.params[:fields][:currency]).to eq(currency)
    expect(form.params[:fields][:signature]).to eq("7ee7cf808ce6a39b17481c54f2c57acc")
    expect(form.params[:fields][:test]).to eq(1)
    expect(form.params[:fields][:responseUrl]).to eq(response_url)
    expect(form.params[:fields][:confirmationUrl]).to eq(confirmation_url)
  end

  private def client
    PayU::Client.new(api_key: "4Vj8eK4rloUd272L48hsrarnUA", account_id: "512321")
  end
end
