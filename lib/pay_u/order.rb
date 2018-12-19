class PayU::Order
  SIGNATURE_JOIN = "~".freeze

  include Virtus.model

  attribute :client, PayU::Client
  attribute :merchant_id, Integer
  attribute :reference, String
  attribute :amount, BigDecimal
  attribute :currency, Symbol
  attribute :status_code, Integer

  def signature
    Digest::MD5.hexdigest([
      client.key,
      merchant_id,
      reference,
      format("%.1f", amount),
      currency,
      status_code,
    ].join(SIGNATURE_JOIN))
  end
end
