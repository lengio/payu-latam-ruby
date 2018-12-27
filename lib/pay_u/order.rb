class PayU::Order
  include Virtus.model

  APPROVED = 4
  DECLINED = 6
  ERROR = 104
  EXPIRED = 5
  PENDING = 7

  attribute :account_id, Integer
  attribute :reference_code, String
  attribute :amount, BigDecimal
  attribute :currency, Symbol
  attribute :status_code, Integer
  attribute :description, String
  attribute :tax, BigDecimal
  attribute :tax_return_base, BigDecimal

  def initialize(params)
    super(params)
  end


  def merchant_id
    PayU.configuration.merchant_id
  end


  def test?
    PayU.configuration.test?
  end


  def response_url
    PayU.configuration.response_url
  end


  def confirmation_url
    PayU.configuration.confirmation_url
  end


  def form
    @form ||= PayU::Form.new(order: self)
  end


  def attributes
    super.merge(merchant_id: merchant_id)
  end
end
