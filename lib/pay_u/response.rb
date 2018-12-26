class PayU::Response
  include Virtus.model

  attribute :client, PayU::Client
  attribute :order, PayU::Order
  attribute :signature, String

  attr_reader :signer

  def initialize(params)
    @client = params.delete(:client)
    @signature = params.delete(:signature)
    @signer = PayU::Signer::Response.new(params.merge(api_key: client.api_key))
    @order = PayU::Order.new(params.merge(client: @client))
  end


  def valid?
    signature == signer.signature
  end
end
