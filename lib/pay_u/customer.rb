class PayU::Customer
  include Virtus.model
  include PayU::Resource

  ENDPOINT = "rest/v#{PayU::API_VERSION}/customers".freeze

  attribute :id, String
  attribute :name, String
  attribute :email, String
  attribute :credit_cards, Array[PayU::CreditCard]

  def self.new_from_api(params)
    customer = super(params)

    customer.name = params["fullName"]

    if params["creditCards"]
      customer.credit_cards = params["creditCards"].map do |credit_card|
        PayU::CreditCard.new_from_api(credit_card)
      end
    end

    customer
  end


  def to_params
    {
      fullName: name,
      email: email,
      creditCards: credit_cards.map(&:to_params),
    }
  end
end
