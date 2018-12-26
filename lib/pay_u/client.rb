class PayU::Client
  include Virtus.model

  attribute :api_key, String
  attribute :account_id, Integer
end
