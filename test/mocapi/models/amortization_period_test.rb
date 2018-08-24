require 'helper'

module Mocapi::Models
  class AmortizationPeriodTest < UnitTest
    def test_new__valid_years
      (5..25).each do |years|
        begin
          AmortizationPeriod.new(years)
        rescue ArgumentError
          flunk format('AmortizationPeriod.new(%d) should not raise', years)
        end
      end
    end

    def test_new__invalid_years__too_short
      (-10..4).each { |years| assert_bad_period(years) }
    end

    def test_new__invalid_years__too_long
      (26..100).each { |years| assert_bad_period(years) }
    end

    def test_to_i
      assert_equal 12, AmortizationPeriod.new(12).to_i
    end

    private

    def assert_bad_period(years)
      AmortizationPeriod.new(years)
      flunk format('AmortizationPeriod.new(%d) should have raised', years)
    rescue
      # success
    end
  end
end

