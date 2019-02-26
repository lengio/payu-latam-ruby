class PayU::Customer
  include Virtus.model
  include PayU::Resource

  ENDPOINT = "/rest/v#{PayU::API_VERSION}/customers".freeze

  attribute :id, String
  attribute :name, String
  attribute :email, String
  attribute :credit_cards, Array[PayU::CreditCard]

  def to_params
    {
      fullName: name,
      email: email,
      creditCards: credit_cards.map(&:to_params),
    }
  end


  def assign_extra_fields(response)
    self.id = response["id"]
  end
end
