module PayU
  class Configuration
    include Virtus.model

    attribute :api_key, String
    attribute :merchant_id, String
    attribute :account_ids, Hash
    attribute :test, Boolean
    attribute :response_url, String
    attribute :confirmation_url, String

    SANDBOX_API_KEY = "4Vj8eK4rloUd272L48hsrarnUA".freeze
    SANDBOX_MERCHANT_ID = 508_029
    SANDBOX_ACCOUNT_IDS = {
      AR: 512_322,
      BR: 512_327,
      CL: 512_325,
      CO: 512_321,
      MX: 512_324,
      PA: 512_326,
      PE: 512_323,
    }.freeze

    def initialize(params = {})
      super(params)

      self.api_key = ENV.fetch("PAYU_API_KEY", SANDBOX_API_KEY) if api_key.nil?
      self.merchant_id = ENV.fetch("PAYU_MERCHANT_ID", SANDBOX_MERCHANT_ID) if merchant_id.nil?
      self.test = ENV.fetch("PAYU_TEST", true) if test.nil?
      self.account_ids = SANDBOX_ACCOUNT_IDS if account_ids.nil?
    end


    def test?
      test
    end
  end

  def self.configuration
    @configuration ||= Configuration.new
  end


  def self.configuration=(configuration)
    @configuration = configuration
  end


  def self.configure
    yield configuration
  end


  def self.reset
    @configuration = Configuration.new
  end
end
