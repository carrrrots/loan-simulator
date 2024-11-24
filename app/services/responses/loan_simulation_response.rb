
module Responses
  class LoanSimulationResponse
    attr_reader :success, :loan_simulation, :error

    def initialize(success:, loan_simulation: nil, error: nil)
      @success = success
      @loan_simulation = loan_simulation
      @error = error
    end

    def success?
      @success
    end
  end
end
