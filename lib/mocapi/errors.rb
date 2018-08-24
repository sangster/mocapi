module Mocapi
  module Errors
    Base = Class.new(StandardError)
    InvalidDownpayment = Class.new(Base)
    InsuranceUnavailable = Class.new(Base)
  end
end
