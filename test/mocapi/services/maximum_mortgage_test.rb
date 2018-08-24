require 'helper'

module Mocapi
  module Services
    class MaximumMortgageTest < UnitTest
      def test_call
        assert_equal 52_000_00, create(100_00, :weekly, 10).call.cents
        assert_equal 26_000_00, create(100_00, :biweekly, 10).call.cents
        assert_equal 12_000_00, create(100_00, :monthly, 10).call.cents

        assert_equal 152_000_00, create(100_00, :weekly, 10, 100_000_00).call.cents
        assert_equal 126_000_00, create(100_00, :biweekly, 10, 100_000_00).call.cents
        assert_equal 112_000_00, create(100_00, :monthly, 10, 100_000_00).call.cents
      end

      def test_call__with_insurance
        assert_equal 50_370_72, create(100_00, :weekly, 10, 9_00).call.cents
        assert_equal 25_389_66, create(100_00, :biweekly, 10, 14_00).call.cents
        assert_equal 11_802_66, create(100_00, :monthly, 10, 19_00).call.cents
      end

      private

      def create(payment, schedule, amortization, downpayment = nil)
        MaximumMortgage.new(
          payment: payment,
          schedule: Models::PaymentSchedule.new(schedule),
          amortization: Models::AmortizationPeriod.new(amortization),
          downpayment: Money.new(downpayment)
        )
      end
    end
  end
end
