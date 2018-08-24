module Mocapi
  module Services
    # Calicate which [Models::Insurance] is required for a particular
    # downpayment on a mortgage.
    class CalculateInsurance
      MAX_MORTGAGE = Money.new(ENV['MAX_MORTGAGE']&.to_i || 1_000_000_00)
      RATE_MIN_DOWNPAYMENT = 0.05
      RATES = {
        0.10 => 0.0315,
        0.15 => 0.024,
        0.20 => 0.018
      }.freeze

      def initialize(downpayment, mortgage)
        @downpayment = Money.new(downpayment)
        @mortgage = Money.new(mortgage)
        @rate = @downpayment / @mortgage

        validate_min_rate!
      end

      # @return [Models::Insurance, nil] +nil+ if insurance is not required
      def call
        if (_, rate = RATES.find { |limit, _| @rate < limit })
          validate_max_mortgage!
          Models::Insurance.new(rate)
        end
      end

      private

      def validate_min_rate!
        return unless @rate < RATE_MIN_DOWNPAYMENT

        raise Errors::InvalidDownpayment,
              format('$%s (%f%%) is too small a downpayment for $%s. Must ' \
                     'be at least %f%%', @downpayment, @rate * 100, @mortgage,
                     RATE_MIN_DOWNPAYMENT * 100)
      end

      def validate_max_mortgage!
        return unless @mortgage > MAX_MORTGAGE

        raise Errors::InsuranceUnavailable,
              format('Insurance is not available for a $%s mortgage, which ' \
                     'is over the limit of $%s', @mortgage, MAX_MORTGAGE)
      end
    end
  end
end
