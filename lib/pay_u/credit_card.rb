class PayU::CreditCard
  include Virtus.model
  include PayU::Resource

  ENDPOINT = "rest/v#{PayU::API_VERSION}/creditCards".freeze

  attribute :token, String
  attribute :name, String
  attribute :document, String
  attribute :number, String
  attribute :exp_month, Integer
  attribute :exp_year, Integer
  attribute :type, String
  attribute :address, Hash
  attribute :customer_id, String

  def to_params
    {
      name: name,
      document: document,
      number: number,
      expMonth: exp_month,
      expYear: exp_year,
      type: type,
      address: address,
    }
  end


  def create_url
    raise StandardError, "Missing customer id" unless customer_id

    "#{PayU::Customer::ENDPOINT}/#{customer_id}/creditCards"
  end
end
