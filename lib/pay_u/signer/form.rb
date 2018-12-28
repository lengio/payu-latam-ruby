module PayU::Signer
  class Form < PayU::Signer::Base
    def fields
      [
        api_key,
        merchant_id,
        reference_code,
        format("%<amount>g", amount: format("%<amount>f", amount: amount)),
        currency,
      ]
    end
  end
end
