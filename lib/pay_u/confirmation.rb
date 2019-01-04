class PayU::Confirmation
  include Virtus.model

  attribute :order, PayU::Order
  attribute :signature, String

  attr_reader :signer

  def initialize(params)
    @signature = params[:sign]
    @order = PayU::Order.new(
      reference_code: params[:reference_sale],
      amount: params[:value].to_f,
      currency: params[:currency],
      status_code: params[:state_pol].to_i,
      response_code: params[:response_code_pol].to_i,
      payment_method_code: params[:payment_method_type].to_i,
      email: params[:email_buyer],
      transaction_id: params[:transaction_id],
    )
    @signer = PayU::Signer::Confirmation.new(@order.attributes)
  end


  def valid?
    signature == signer.signature
  end
end
