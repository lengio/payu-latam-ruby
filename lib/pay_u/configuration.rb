module PayU
  class Configuration
    include Virtus.model

    attribute :test, Boolean
    attribute :api_key, String
    attribute :response_url, String
    attribute :confirmation_url, String

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
