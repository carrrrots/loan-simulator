class LoanSimulationValidator
  def self.validate!(params)
    raise ArgumentError, 'Loan amount must be a positive number' unless params[:loan_amount].is_a?(Numeric) && params[:loan_amount] > 0
    raise ArgumentError, 'Term in months must be a positive integer' unless params[:term_in_months].is_a?(Integer) && params[:term_in_months] > 0
    raise ArgumentError, 'Invalid birthdate' unless params[:birthdate].is_a?(Date)
  end

  def self.validate_positive_integer!(value, name)
    raise ArgumentError, "#{name} must be a positive integer" unless value.is_a?(Integer) && value > 0
  end
end
