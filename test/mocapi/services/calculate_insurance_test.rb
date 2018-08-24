require 'helper'

module Mocapi
  module Services
    class CalculateInsuranceTest < UnitTest
      def test_new__min_rate
        create(1_000_00 * 0.05, 1_000_00)

        assert_raises(Errors::InvalidDownpayment) do
          create(0_00, 1_000_00)
        end
        assert_raises(Errors::InvalidDownpayment) do
          create(1_000_00 * 0.04, 1_000_00)
        end
      end

      def test_call__max_mortgage
        create(1_000_000_00 * 0.05, 1_000_000_00).call

        assert_raises(Errors::InsuranceUnavailable) do
          create(1_000_001_00 * 0.05, 1_000_001_00).call
        end
      end

      def test_call
        assert_equal 0.0315, create(5_00, 100_00).call.rate
        assert_equal 0.0315, create(9_99, 100_00).call.rate
        assert_equal 0.024, create(10_00, 100_00).call.rate
        assert_equal 0.024, create(14_99, 100_00).call.rate
        assert_equal 0.018, create(15_00, 100_00).call.rate
        assert_equal 0.018, create(19_99, 100_00).call.rate

        assert_nil create(20_01, 100_00).call
      end

      private

      def create(downpayment, mortgage)
        CalculateInsurance.new(downpayment, mortgage)
      end
    end
  end
end
