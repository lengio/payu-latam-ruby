module Fixtures
  def self.credit_card
    {
      name: "Sample User Name",
      document: "1020304050",
      number: "4242424242424242",
      exp_month: 12,
      exp_year: 20,
      type: "VISA",
    }
  end
end
