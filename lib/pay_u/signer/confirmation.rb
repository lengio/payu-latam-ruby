module PayU::Signer
  class Confirmation < PayU::Signer::Base
    def fields
      value = format("%.2f", amount)

      [
        api_key,
        merchant_id,
        reference_code,
        value[-1] == "0" ? value[0..-2] : value,
        currency,
        status_code,
      ]
    end
  end
end
