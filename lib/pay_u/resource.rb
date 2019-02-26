module PayU::Resource
  def self.included(base)
    base.extend(ClassMethods)
  end


  def save; end


  def delete; end


  def create_url
    self.class::ENDPOINT
  end


  def identifier
    id
  end


  module ClassMethods
    def client
      @client ||= PayU::Client.instance
    end


    def retrieve(identifier)
      response = client.get "#{self::ENDPOINT}/#{identifier}", headers: {}

      new(response)
    end


    def create(params)
      resource = new(params)

      response = client.post resource.create_url, params: resource.to_params, headers: {}
      resource.assign_extra_fields(response)

      resource
    end
  end
end
