module Helpers
  def stub_subscription_request
    stub_request(:post, /#{PayU::Subscription::ENDPOINT}/)
      .to_return do |request|
        {body: File.new("./spec/fixtures/responses/subscription.json").read
          .gsub("{{code}}", JSON.parse(request.body)["plan"]["planCode"])}
      end
  end


  def stub_plan_request
    stub_request(:any, /#{PayU::Plan::ENDPOINT}/)
      .to_return do |request|
        code = if request.method == :post
                 JSON.parse(request.body)["planCode"]
               else
                 request.uri.path.split("/").last
               end

        {body: File.new("./spec/fixtures/responses/plan.json").read.gsub("{{code}}", code)}
      end
  end


  def stub_customer_request
    stub_request(:post, /#{PayU::Customer::ENDPOINT}$/)
      .to_return(body: File.new("./spec/fixtures/responses/customer.json"))
  end


  def stub_credit_card_request
    stub_request(:post, %r{#{PayU::Customer::ENDPOINT}/.+/creditCards})
      .to_return(body: {token: SecureRandom.uuid}.to_json)
  end
end
