module Mocapi
  module Models
    class Insurance
      extend Forwardable

      attr_reader :rate
      def_delegator :rate, :positive?

      def initialize(rate)
        @rate = rate
      end
    end
  end
end
