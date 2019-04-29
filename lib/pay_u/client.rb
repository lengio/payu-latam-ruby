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


  def get(url)
    response = @client.get(&perform_request(url))

    process_response(response)
  end


  def post(url, params: {})
    response = @client.post(&perform_request_with_params(url, params))

    process_response(response)
  end


  def put(url, params: {})
    response = @client.put(&perform_request_with_params(url, params))

    process_response(response)
  end


  def delete(url)
    response = @client.delete(&perform_request(url))

    response.success?
  end


  private def perform_request(url)
    proc do |request|
      request.url "payments-api/#{url}"
      request.headers = request.headers.merge(default_headers)
    end
  end


  private def perform_request_with_params(url, params)
    proc do |request|
      request.url "payments-api/#{url}"
      request.headers = request.headers.merge(default_headers)
      request.body = params.delete_if { |_, value| value.nil? }.to_json
    end
  end


  private def process_response(response)
    raise PayU::UnauthorizedError, "Unauthorized" if !response.success? && response.status == 401

    body = JSON.parse(response.body)

    return raise_error(response) unless response.success?

    body
  end

  private def raise_error(response)
    body = JSON.parse(response.body)

    error_message = body["errorList"] ? body["errorList"].join : body["description"]

    raise PayU::NotFoundError, error_message if response.status == 404
    raise PayU::Error, error_message
  end


  private def default_headers
    {
      "Content-Type" => "application/json; charset=utf-8",
      "Accept" => "application/json",
    }
  end
end
