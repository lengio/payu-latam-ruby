class PayU::Confirmation
  include Virtus.model

  attribute :client, PayU::Client
  attribute :order, PayU::Order
  attribute :signature, String

  def initialize(params)
    @client = params.delete(:client)
    @signature = params.delete(:signature)
    signer = PayU::Signer::Confirmation.new(params.merge(api_key: client.api_key))
    @order = PayU::Order.new(params.merge(client: @client), signer)
  end


  def valid?
    signature == order.signature
  end
end
