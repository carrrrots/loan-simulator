class PaymentCalculator
  attr_reader :loan_amount, :interest_rate, :term_in_months

  def initialize(loan_amount:, interest_rate:, term_in_months:)
    LoanSimulationValidator.validate!(
      loan_amount: loan_amount,
      term_in_months: term_in_months,
      birthdate: Date.today # Apenas para compatibilidade com o método
    )
    @loan_amount = loan_amount
    @interest_rate = validate_interest_rate(interest_rate)
    @term_in_months = term_in_months
  end

  def calculate
    return 0 if @term_in_months.zero?

    (numerator / denominator).round(2)
  end

  private

  def monthly_interest_rate
    @interest_rate / 12
  end

  def numerator
    @loan_amount * monthly_interest_rate
  end

  def denominator
    denom = 1 - (1 + monthly_interest_rate)**-@term_in_months
    raise ArgumentError, "Term in months results in an invalid denominator" if denom.zero?

    denom
  end

  def validate_interest_rate(value)
    raise ArgumentError, "Interest rate must be a positive number" unless value.is_a?(Numeric) && value > 0
    value
  end
end
