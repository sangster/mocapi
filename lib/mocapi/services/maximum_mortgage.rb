module Mocapi
  module Services
    class MaximumMortgage
      # @param payment [Money]
      # @param schedule [PaymentSchedule]
      # @param amortization [AmortizationPeriod]
      # @param downpayment [Money]
      def initialize(payment:, schedule:, amortization:,
                     downpayment: Money.empty)
        @payment = payment
        @schedule = schedule
        @amortization = amortization
        @downpayment = downpayment
      end

      def call
        max = max_uninsured
        insurance&.positive? ? max - max * insurance.rate : max
      end

      private

      def max_uninsured
        Money.new(@payment / @schedule.to_r * @amortization.to_i) + @downpayment
      end

      def insurance
        if @downpayment.positive?
          CalculateInsurance.new(@downpayment, @payment).call
        end
      end
    end
  end
end
