module Mocapi
  module Models
    class AmortizationPeriod
      VALID_RANGE = (5..25).freeze

      # @param years [Integer] The length of the amortization period, in years
      def initialize(years)
        unless VALID_RANGE.include?(years)
          raise ArgumentError,
            format('Amortization of %d years is not within valid range of %p',
                   years, VALID_RANGE)
        end

        @years = years
      end

      def to_i
        @years
      end
    end
  end
end
