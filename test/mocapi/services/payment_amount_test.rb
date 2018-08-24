require 'helper'

module Mocapi
  module Services
    class PaymountAmountTest < UnitTest
      def test_call
        assert_equal 153_85, create(20_000_00, 100_000_00, :weekly, 10, 0).call.cents
        assert_equal 307_69, create(20_000_00, 100_000_00, :biweekly, 10, 0).call.cents
        assert_equal 666_67, create(20_000_00, 100_000_00, :monthly, 10, 0).call.cents
      end

      def test_call__with_interest
        assert_equal 169_23, create(20_000_00, 100_000_00, :weekly, 10, 0.1).call.cents
        assert_equal 338_46, create(20_000_00, 100_000_00, :biweekly, 10, 0.1).call.cents
        assert_equal 733_33, create(20_000_00, 100_000_00, :monthly, 10, 0.1).call.cents
      end

      private

      def create(downpayment, mortgage, schedule, amortization, interest_rate)
        PaymountAmount.new(
          downpayment: downpayment,
          mortgage: mortgage,
          schedule: Models::PaymentSchedule.new(schedule),
          amortization: Models::AmortizationPeriod.new(amortization),
          interest_rate: interest_rate
        )
      end
    end
  end
end
