module Mocapi
  module Models
    class Downpayment < Money
      RATE_UNDER = ENV['RATE_UNDER']&.to_f || 0.05
      RATE_OVER = ENV['RATE_OVER']&.to_f || 0.10
      RATE_INSURANCE_OPTIONAL = ENV['RATE_INSURANCE_OPTIONAL']&.to_f || 0.20
      OVERAGE_FLOOR = Money.new(ENV['OVERAGE_FLOOR']&.to_f || 500_000_00).freeze

      class << self
        # @param mortgage [Money, Integer]
        # @return The minimum downpayment required for the given mortgage
        def minimum(mortgage)
          mortgage = Money.new(mortgage)
          under = [mortgage, OVERAGE_FLOOR].min
          over  = [mortgage - OVERAGE_FLOOR, Money.zero].max

          new(RATE_UNDER * under + RATE_OVER * over)
        end
      end

      # @param mortgage [Money]
      def enough_for?(mortgage)
        self >= Downpayment.minimum(mortgage)
      end

      # @param mortgage [Money, Integer]
      def requires_insurance?(mortgage)
        self < Money.new(mortgage) * RATE_INSURANCE_OPTIONAL
      end
    end
  end
end
