class PayU::Client
  attr_accessor :key, :merchant_id

  def initialize(key:, merchant_id:)
    @key = key
    @merchant_id = merchant_id
  end
end
