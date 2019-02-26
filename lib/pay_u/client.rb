require "base64"

class PayU::Client
  include Singleton

  def initialize
    @client ||= Faraday.new(url: PayU.configuration.api_url) do |faraday|
      faraday.request :url_encoded
      faraday.response :logger if PayU.configuration.test?
      faraday.adapter Faraday.default_adapter
    end
  end


  def get(url, headers: {})
    response = @client.get do |req|
      req.url "payments-api/#{url}"
      req.headers = default_headers.merge(headers)
    end

    process_response(response)
  end


  def post(url, params: {}, headers: {})
    response = @client.post do |req|
      req.url "payments-api/#{url}"
      req.headers = default_headers.merge(headers)
      req.body = params.delete_if { |_key, value| value.nil? }.to_json
    end

    process_response(response)
  end


  private def process_response(response)
    body = JSON.parse(response.body)

    unless response.success?
      raise StandardError, body["errorList"] ? body["errorList"].join : body["description"]
    end

    body
  end


  private def default_headers
    {
      "Content-Type" => "application/json; charset=utf-8",
      "Accept" => "application/json",
      "Authorization" => "Basic #{Base64.encode64('pRRXKOl8ikMmt9u:4Vj8eK4rloUd272L48hsrarnUA')}",
    }
  end
end
