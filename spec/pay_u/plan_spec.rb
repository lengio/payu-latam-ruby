require "spec_helper"

RSpec.describe PayU::Plan do
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

  it "raises when trying to retrieve non-existent plan" do
    expect do
      PayU::Plan.retrieve("non-existent")
    end.to raise_exception(StandardError, /Subscription plan not found/)
  end
end
