class PayU::Order
  include Virtus.model

  attribute :client, PayU::Client
  attribute :account_id, Integer
  attribute :merchant_id, Integer
  attribute :reference_code, String
  attribute :amount, BigDecimal
  attribute :currency, Symbol
  attribute :status_code, Integer
  attribute :description, String
  attribute :tax, BigDecimal
  attribute :tax_return_base, BigDecimal
  attribute :buyer_email, String

  attr_reader :signer

  def initialize(params, signer)
    super(params)
    @signer = signer
  end


  def signature
    signer.signature
  end


  def test; end


  def response_url
    PayU.configuration.response_url
  end


  def confirmation_url
    PayU.configuration.confirmation_url
  end
end
