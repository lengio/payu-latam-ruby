require "base64"

class PayU::Client
  include Singleton

  def initialize
    @client ||= Faraday.new(url: PayU.configuration.api_url) do |connection|
      connection.request :url_encoded
      connection.response :logger if PayU.configuration.test?
      connection.adapter Faraday.default_adapter
      connection.basic_auth "pRRXKOl8ikMmt9u", "4Vj8eK4rloUd272L48hsrarnUA"
    end
  end


  def get(url, headers: {})
    response = @client.get do |request|
      request.url "payments-api/#{url}"
      request.headers = request.headers.merge(default_headers).merge(headers)
    end

    process_response(response)
  end


  def post(url, params: {}, headers: {})
    response = @client.post do |request|
      request.url "payments-api/#{url}"
      request.headers = request.headers.merge(default_headers).merge(headers)
      request.body = params.delete_if { |_key, value| value.nil? }.to_json
    end

    process_response(response)
  end


  private def process_response(response)
    unless response.success?
      raise StandardError, "Unauthorized" if response.status == 401
      raise StandardError, response.body
    end

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
    }
  end
end
