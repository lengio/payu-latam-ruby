require "spec_helper"

RSpec.describe PayU::Plan do
  before do
    stub_request(:any, /#{PayU::Plan::ENDPOINT}/)
      .to_return do |request|
        code = if request.method == :post
                 JSON.parse(request.body)["planCode"]
               else
                 request.uri.path.split("/").last
               end

        {body: File.new("./spec/fixtures/responses/plan.json").read.gsub("{{code}}", code)}
      end

    stub_request(:get, %r{#{PayU::Plan::ENDPOINT}/non-existent}).to_return(
      status: 404,
      body: File.new("./spec/fixtures/responses/plan_not_found.json"),
    )
  end

  it "creates plan" do
    plan = PayU::Plan.create(Fixtures.plan)

    expect(plan.id).to match(/\b[0-9a-f]{8}\b-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-\b[0-9a-f]{12}\b/)
  end

  it "retrieves plan" do
    code = "pro-#{SecureRandom.hex(4)}"
    plan = PayU::Plan.create(Fixtures.plan.merge(code: code))

    found_plan = PayU::Plan.retrieve(plan.code)

    expect(found_plan.id).to match(plan.id)
  end

  it "updates plan" do
    WebMock.disable!
    plan = PayU::Plan.create(Fixtures.plan)
    id = plan.id
    description = "Description"

    plan.description = description
    plan.save

    expect(plan.id).to eq(id)
    expect(plan.description).to eq(description)

    WebMock.enable!
  end

  it "deletes plan" do
    WebMock.disable!
    plan = PayU::Plan.create(Fixtures.plan)

    plan.delete

    expect do
      PayU::Plan.retrieve(plan.code)
    end.to raise_exception(PayU::NotFoundError, /Subscription plan not found/)

    WebMock.enable!
  end
end
