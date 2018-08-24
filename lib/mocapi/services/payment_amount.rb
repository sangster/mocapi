module Mocapi
  module Services
    class PaymountAmount
      # @param downpayment [Models::Downpayment, Integer]
      # @param mortgage [Money, Integer]
      # @param schedule [Models::PaymentSchedule]
      # @param amortization [Models::AmortizationPeriod]
      def initialize(downpayment, mortgage, schedule, amortization)
        @downpayment = Models::Downpayment.new(downpayment)
        @mortgage = Money.new(mortgage)
        @schedule = schedule
        @amortization = amortization
      end

      def call
        sum = @mortgage
        if (insurance = CalculateInsurance.new(@downpayment, @mortgage).call)
          sum += sum * insurance.rate
        end
        sum -= @downpayment

        annual = sum / @amortization.to_i.to_f
        annual * @schedule.to_r

        # TODO: int_fact = (1 + interest_rate) ** n
        # TODO: principle * ((interest_rate * int_fact) / (int_fact - 1))
      end
    end
  end
end
