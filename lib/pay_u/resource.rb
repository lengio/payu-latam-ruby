module PayU::Resource
  def self.included(base)
    base.extend(ClassMethods)
  end


  def save
    return update if id

    self.attributes = self.class.create(attributes).attributes

    true
  end


  def delete
    self.class.client.delete url
  end


  def create_url
    self.class::ENDPOINT
  end


  def to_update_params
    to_params
  end


  private def update
    response = self.class.client.put url, params: to_update_params
    self.attributes = attributes.merge(self.class.new_from_api(response).attributes)
  end


  private def identifier
    id
  end


  private def url
    "#{self.class::ENDPOINT}/#{identifier}"
  end


  module ClassMethods
    def client
      @client ||= PayU::Client.instance
    end


    def new_from_api(params)
      resource = new

      resource.attributes = params.inject({}) do |memo, (key, value)|
        local_key = key.to_underscore.to_sym

        resource.respond_to?(local_key) ? memo.merge(local_key => value) : memo
      end

      resource
    end


    def retrieve(identifier)
      response = client.get "#{self::ENDPOINT}/#{identifier}"

      new_from_api(response)
    end


    def create(params)
      resource = new(params)

      response = client.post resource.create_url, params: resource.to_params

      new_from_api(response)
    end
  end
end
