class PayU::Response
  include Virtus.model

  EVENT = "payu.response".freeze

  attribute :order, PayU::Order
  attribute :signature, String

  attr_reader :signer

  def initialize(params)
    @signature = params[:signature]
    @order = PayU::Order.new(
      reference_code: params[:referenceCode],
      amount: params[:TX_VALUE].to_f,
      currency: params[:currency],
      status_code: params[:transactionState].to_i,
      response_code: params[:polResponseCode].to_i,
      response_message: params[:lapResponseCode],
      payment_method: params[:lapPaymentMethod],
      payment_method_code: params[:polPaymentMethodType].to_i,
      email: params[:buyerEmail],
      transaction_id: params[:transactionId],
      extra_1: params[:extra1],
      extra_2: params[:extra2],
      extra_3: params[:extra3],
    )
    @signer = PayU::Signer::Response.new(@order.attributes)
  end


  def valid?
    signature == signer.signature
  end
end
