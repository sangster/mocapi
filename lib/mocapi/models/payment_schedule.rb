module Mocapi
  module Models
    class PaymentSchedule
      PERIODS = {
        weekly:   1/52r,
        biweekly: 2/52r,
        monthly:  1/12r,
      }.freeze

      # @param period [Symbol] Must be one of: +:weekly+, +:biweekly+, +:monthly+
      def initialize(period)
        unless PERIODS.keys.include?(period)
          raise ArgumentError, format('Unknown payment schedule: %s', period)
        end

        @period = period
      end

      def to_r
        PERIODS[@period]
      end
    end
  end
end
