module PayU::Signer
  class Base
    SIGNATURE_JOIN = "~".freeze

    include Virtus.model

    attribute :merchant_id, Integer
    attribute :reference_code, String
    attribute :amount, BigDecimal
    attribute :currency, Symbol
    attribute :status_code, Integer

    def signature
      Digest::MD5.hexdigest(fields.join(SIGNATURE_JOIN))
    end


    private def api_key
      PayU.configuration.api_key
    end
  end
end
