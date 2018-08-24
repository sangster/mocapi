require 'helper'

module Mocapi::Models
  class DownpaymentTest < UnitTest
    def test_minimum
      assert_equal         0, Downpayment.empty.cents
      assert_equal    500_00, Downpayment.minimum(10_000_00).cents
      assert_equal 24_975_00, Downpayment.minimum(499_500_00).cents
      assert_equal 25_000_00, Downpayment.minimum(500_000_00).cents
      assert_equal 25_050_00, Downpayment.minimum(500_500_00).cents
      assert_equal 50_000_00, Downpayment.minimum(750_000_00).cents
    end

    def test_enough?
      assert_enough_for(        0,          0)
      assert_enough_for(   500_00,  10_000_00)
      assert_enough_for(24_975_00, 499_500_00)
      assert_enough_for(25_000_00, 500_000_00)
      assert_enough_for(25_050_00, 500_500_00)
      assert_enough_for(50_000_00, 750_000_00)

      refute_enough_for(        0,       1_00)
      refute_enough_for(   500_00,  10_001_00)
      refute_enough_for(24_975_00, 499_501_00)
      refute_enough_for(25_000_00, 500_001_00)
      refute_enough_for(25_050_00, 500_501_00)
      refute_enough_for(50_000_00, 750_001_00)
    end

    def test_requires_insurance?
      assert_requires_insurance(19_999_00, 100_000_00)

      refute_requires_insurance(20_000_00, 100_000_00)
    end

    private

    def assert_enough_for(downpayment, mortgage)
      assert Downpayment.new(downpayment).enough_for?(mortgage),
             format('%s should be enough for a mortgage of %s', downpayment,
                    mortgage)
    end

    def refute_enough_for(downpayment, mortgage)
      refute Downpayment.new(downpayment).enough_for?(mortgage),
             format('%s should not be enough for a mortgage of %s', downpayment,
                    mortgage)
    end

    def assert_requires_insurance(downpayment, mortgage)
      assert Downpayment.new(downpayment).requires_insurance?(mortgage),
             format('%s should require insurance for a mortgage of %s',
                    downpayment, mortgage)
    end

    def refute_requires_insurance(downpayment, mortgage)
      refute Downpayment.new(downpayment).requires_insurance?(mortgage),
             format('%s should not require insurance for a mortgage of %s',
                    downpayment, mortgage)
    end
  end
end
