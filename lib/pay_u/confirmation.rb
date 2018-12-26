class PayU::Confirmation
  include Virtus.model

  attribute :order, PayU::Order
  attribute :signature, String

  attr_reader :signer

  def initialize(params)
    @client = params.delete(:client)
    @signature = params.delete(:signature)
    @order = PayU::Order.new(params)
    @signer = PayU::Signer::Confirmation.new(@order.attributes)
  end


  def valid?
    signature == signer.signature
  end
end
