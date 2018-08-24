require 'money'
require 'sinatra'
require 'sinatra/contrib'
I18n.config.available_locales = :en

module Mocapi
  module Version
    MAJOR = 0
    MINOR = 1
    PATCH = 0
    BUILD = 'alpha'.freeze

    STRING = [MAJOR, MINOR, PATCH, BUILD].compact.join('.')
  end

  autoload :Errors, 'mocapi/errors'
  autoload :Server, 'mocapi/server'

  module Services
    autoload :CalculateInsurance, 'mocapi/services/calculate_insurance'
    autoload :MaximumMortgage,    'mocapi/services/maximum_mortgage'
    autoload :PaymountAmount,     'mocapi/services/payment_amount'
  end

  module Models
    autoload :AmortizationPeriod, 'mocapi/models/amortization_period'
    autoload :Downpayment,        'mocapi/models/downpayment'
    autoload :Insurance,          'mocapi/models/insurance'
    autoload :PaymentSchedule,    'mocapi/models/payment_schedule'
  end
end
