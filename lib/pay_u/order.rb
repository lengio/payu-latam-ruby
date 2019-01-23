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
  attribute :description, String
  attribute :tax, BigDecimal
  attribute :tax_return_base, BigDecimal
  attribute :status_code, Integer
  attribute :response_code, Integer
  attribute :response_message, String
  attribute :payment_method, String
  attribute :payment_method_code, Integer
  attribute :email, String
  attribute :transaction_id, String
  attribute :extra_1, String
  attribute :extra_2, String
  attribute :extra_3, String
  attribute :cc_number, String

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


  def approved?
    status_code == APPROVED
  end


  def declined?
    status_code == DECLINED
  end


  def error?
    status_code == ERROR
  end


  def pending?
    status_code == PENDING
  end


  def expired?
    status_code == EXPIRED
  end
end
