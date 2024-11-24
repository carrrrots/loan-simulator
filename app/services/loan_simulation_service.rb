require 'loan_simulation_validator.rb'

class LoanSimulationService
  def initialize(params)
    @loan_amount = params[:loan_amount]
    @birthdate = parse_date(params[:birthdate])
    @term_in_months = params[:term_in_months]
  end

  def perform
    validate_params!

    age = calculate_age(@birthdate)
    interest_rate = fetch_interest_rate(age)
    monthly_payment = calculate_monthly_payment(interest_rate)
    build_success_response(monthly_payment, interest_rate)
  rescue ArgumentError => e
    build_error_response(e.message)
  end

  private

  def validate_params!
    LoanSimulationValidator.validate!(
      loan_amount: @loan_amount,
      term_in_months: @term_in_months,
      birthdate: @birthdate
    )
  end

  def parse_date(date)
    Date.parse(date)
  rescue ArgumentError
    raise ArgumentError, 'Invalid date format'
  end

  def calculate_age(birthdate)
    AgeCalculator.new(birthdate).calculate
  end

  def fetch_interest_rate(age)
    InterestRateCalculator.new.calculate(age)
  end

  def calculate_monthly_payment(interest_rate)
    PaymentCalculator.new(
      loan_amount: @loan_amount,
      interest_rate: interest_rate,
      term_in_months: @term_in_months
    ).calculate
  end

  def build_success_response(monthly_payment, interest_rate)
    total_amount = monthly_payment * @term_in_months
    total_interest = total_amount - @loan_amount

    Responses::LoanSimulationResponse.new(
      success: true,
      loan_simulation: LoanSimulation.new(
        loan_amount: @loan_amount,
        term_in_months: @term_in_months,
        interest_rate: interest_rate,
        birthdate: @birthdate,
        monthly_payment: monthly_payment.round(2),
        total_amount: total_amount.round(2),
        total_interest: total_interest.round(2)
      )
    )
  end

  def build_error_response(error_message)
    Responses::LoanSimulationResponse.new(success: false, error: error_message)
  end
end
