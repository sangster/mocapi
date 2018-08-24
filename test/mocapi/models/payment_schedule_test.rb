require 'helper'

module Mocapi::Models
  class PaymentScheduleTest < UnitTest
    def test_new__periods
      PaymentSchedule.new(:weekly)
      PaymentSchedule.new(:biweekly)
      PaymentSchedule.new(:monthly)
      assert_raises(ArgumentError) { PaymentSchedule.new(:something_else) }
    end

    def test_to_i
      assert_equal 1, PaymentSchedule.new(:weekly).to_r * 52
      assert_equal 1, PaymentSchedule.new(:biweekly).to_r * 26
      assert_equal 1, PaymentSchedule.new(:monthly).to_r * 12
    end
  end
end
