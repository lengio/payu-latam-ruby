module PayU::Signer
  class Response < PayU::Signer::Base
    def fields
      [
        api_key,
        merchant_id,
        reference_code,
        format("%.1f", amount),
        currency,
        status_code,
      ]
    end
  end
end
