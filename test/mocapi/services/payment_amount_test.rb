require 'helper'

module Mocapi
  module Services
    class PaymountAmountTest < UnitTest
      def test_call
        assert_equal 153_85, create(20_000_00, 100_000_00, :weekly, 10).call.cents
        assert_equal 307_69, create(20_000_00, 100_000_00, :biweekly, 10).call.cents
        assert_equal 666_67, create(20_000_00, 100_000_00, :monthly, 10).call.cents
      end

      private

      def create(downpayment, mortgage, schedule, amortization)
        PaymountAmount.new(
          downpayment,
          mortgage,
          Models::PaymentSchedule.new(schedule),
          Models::AmortizationPeriod.new(amortization)
        )
      end
    end
  end
end
