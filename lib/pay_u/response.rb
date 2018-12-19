class PayU::Response
  include Virtus.model

  attribute :client, PayU::Client
  attribute :order, PayU::Order
  attribute :signature, String

  def initialize(params)
    @client = params.delete(:client)
    @signature = params.delete(:signature)
    @order = PayU::Order.new(params.merge(client: @client))
  end


  def valid?
    signature == order.signature
  end
end
