class PayU::Form
  include Virtus.model

  attribute :client, PayU::Client
  attribute :order, PayU::Order

  def initialize(params)
    @client = params.delete(:client)
    signer = PayU::Signer::Form.new(params.merge(api_key: client.api_key))
    @order = PayU::Order.new(params.merge(client: @client), signer)
  end


  def signature
    order.signature
  end
end
