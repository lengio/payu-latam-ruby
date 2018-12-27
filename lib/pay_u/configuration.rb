module PayU
  class Configuration
    include Virtus.model

    attribute :api_key, String
    attribute :merchant_id, String
    attribute :test, Boolean
    attribute :response_url, String
    attribute :confirmation_url, String

    def initialize(params = {})
      super(params)

      self.api_key = ENV.fetch("PAYU_API_KEY", "4Vj8eK4rloUd272L48hsrarnUA") if api_key.nil?
      self.merchant_id = ENV.fetch("PAYU_MERCHANT_ID", 508_029) if merchant_id.nil?
      self.test = ENV.fetch("PAYU_TEST", true) if test.nil?
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
