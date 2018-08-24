module Mocapi
  module Services
    # Calculates the requiremed payment, per payment period for a given
    # mortgage. This calculation includes compound interest and possible
    # insurance requirements.
    class PaymountAmount
      # @param downpayment [Models::Downpayment, Integer]
      # @param mortgage [Money, Integer]
      # @param schedule [Models::PaymentSchedule]
      # @param amortization [Models::AmortizationPeriod]
      # @param interest_rate [Float]
      def initialize(downpayment:, mortgage:, schedule:, amortization:,
                     interest_rate:)
        @downpayment = Models::Downpayment.new(downpayment)
        @mortgage = Money.new(mortgage)
        @schedule = schedule
        @amortization = amortization
        @interest_rate = interest_rate
      end

      def call
        total / (@amortization.to_i / @schedule.to_r)
      end

      private

      def total
        principle = @mortgage
        if (insurance = CalculateInsurance.new(@downpayment, @mortgage).call)
          principle += principle * insurance.rate
        end

        principle -= @downpayment
        principle + compound_interest(principle)
      end

      def compound_interest(principle)
        if @interest_rate&.positive?
          num_payments = @amortization.to_i / @schedule.to_r
          principle * compound_interest_rate(num_payments, @interest_rate)
        else
          0
        end
      end

      def compound_interest_rate(num_payments, interest_rate)
        int_fact = (1 + interest_rate)**num_payments
        (interest_rate * int_fact) / (int_fact - 1)
      end
    end
  end
end
