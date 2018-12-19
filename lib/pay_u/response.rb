class PayU::Response
  SIGNATURE_JOIN = "~".freeze

  attr_reader :client, :merchant_id, :reference, :amount, :currency, :status_code, :signature
  private :client, :signature

  def initialize(client:, params: {})
    @client = client
    @merchant_id = params[:merchant_id]
    @reference = params[:reference]
    @amount = params[:amount]
    @currency = params[:currency]
    @status_code = params[:status_code]
    @signature = params[:signature]
  end


  def valid?
    signature == Digest::MD5.hexdigest([
      client.key,
      merchant_id,
      reference,
      format("%.1f", amount),
      currency,
      status_code,
    ].join(SIGNATURE_JOIN))
  end
end
