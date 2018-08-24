module Mocapi
  class Server < Sinatra::Base
    MORTGAGE_INTEREST_DEFAULT = 0.025

    set :server, 'thin'
    set :interest, ENV['MORTGAGE_INTEREST']&.to_f || MORTGAGE_INTEREST_DEFAULT

    get '/payment-amount' do
    end

    # Render the maximum mortgage (in cents) for the given payment schedule
    get '/mortgage-amount' do
      service =
        Services::MaximumMortgage.new(
          payment: Money.new(Integer(params['payment'])),
          schedule: Models::PaymentSchedule.new(params['schedule']&.to_sym),
          amortization: Models::AmortizationPeriod.new(Integer(params['amortization'])),
          downpayment: Money.new(params['downpayment']&.to_i)
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
        message: env['sinatra.error'].message,
      }
    end

    error ArgumentError, &JSON_BAD_REQUEST
    error Errors::Base, &JSON_BAD_REQUEST
  end
end
