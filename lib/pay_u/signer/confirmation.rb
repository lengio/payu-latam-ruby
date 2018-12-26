module PayU::Signer
  class Confirmation < PayU::Signer::Base
    def fields
      [
        api_key,
        merchant_id,
        reference_code,
        format("%.2f", amount),
        currency,
        status_code,
      ]
    end
  end
end
