class PayU::Client
  include Virtus.model

  attribute :key, String
  attribute :merchant_id, Integer
end
