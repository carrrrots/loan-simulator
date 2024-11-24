class InterestRateCalculator
  def calculate(age)
    LoanSimulationValidator.validate_positive_integer!(age, "Age")

    case age
    when 0..25
      0.05
    when 26..40
      0.03
    when 41..60
      0.02
    else
      0.04
    end
  end

  private

  def validate_positive_integer(value, name)
    raise ArgumentError, "#{name} must be a positive integer" unless value.is_a?(Integer) && value > 0
    value
  end
end
