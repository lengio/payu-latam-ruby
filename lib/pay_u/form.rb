class PayU::Form
  include Virtus.model

  attribute :order, PayU::Order

  attr_reader :signer

  def initialize(params)
    super(params)
    @signer = PayU::Signer::Form.new(order.attributes)
  end


  def signature
    signer.signature
  end


  def params
    {
      action: order.test? ? PayU::TEST_URL : PayU::LIVE_URL,
      fields: {
        merchantId: order.merchant_id,
        accountId: order.account_id,
        description: order.description,
        referenceCode: order.reference_code,
        amount: order.amount,
        tax: order.tax,
        taxReturnBase: order.tax_return_base,
        currency: order.currency,
        signature: signature,
        test: order.test? ? "1" : "0",
        responseUrl: order.response_url,
        confirmationUrl: order.confirmation_url,
      },
    }
  end
end
