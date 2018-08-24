module Mocapi
  class Server < Sinatra::Base
    set :server, 'thin'
    set :interest, ENV['MORTGAGE_INTEREST']&.to_f || 0.025

    get '/payment-amount' do
      service =
        Services::PaymountAmount.new(
          downpayment: Money.new(Integer(params['downpayment'])),
          mortgage: Money.new(Integer(params['mortgage'])),
          schedule: Models::PaymentSchedule.new(params['schedule']&.to_sym),
          interest_rate: settings.interest,
          amortization: Models::AmortizationPeriod.new(
            Integer(params['amortization'])
          )
        )

      json amount: service.call.cents
    end

    # Render the maximum mortgage (in cents) for the given payment schedule
    get '/mortgage-amount' do
      service =
        Services::MaximumMortgage.new(
          payment: Money.new(Integer(params['payment'])),
          schedule: Models::PaymentSchedule.new(params['schedule']&.to_sym),
          downpayment: Money.new(params['downpayment']&.to_i),
          amortization: Models::AmortizationPeriod.new(
            Integer(params['amortization'])
          )
        )

      json maximum: service.call.cents
    end

    # Configure the system's interest rate (in decimal, ex: +0.10 == 10%+)
    patch '/interest-rate' do
      old_interest = settings.interest
      settings.interest = Float(params[:interest])

      json old: old_interest, new: settings.interest
    end

    JSON_BAD_REQUEST = proc do
      status 400
      json error: {
        code: response.status,
        message: env['sinatra.error'].message
      }
    end

    error ArgumentError, &JSON_BAD_REQUEST
    error Errors::Base, &JSON_BAD_REQUEST
  end
end
