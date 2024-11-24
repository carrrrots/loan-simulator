class LoanSimulationsController < ApplicationController
  def create
    loan_simulation = build_loan_simulation

    if save_loan_simulation(loan_simulation)
      render json: loan_simulation, status: :created
    else
      handle_save_error(loan_simulation)
    end
  rescue ArgumentError => e
    handle_argument_error(e)
  end

  private

  def build_loan_simulation
    LoanSimulationService.new(loan_simulation_params).perform
  end

  def save_loan_simulation(loan_simulation)
    LoanSimulationRepository.new.create(loan_simulation)
  end

  def loan_simulation_params
    params.permit(:loan_amount, :birthdate, :term_in_months)
  end

  def handle_save_error(loan_simulation)
    errors = loan_simulation&.errors&.full_messages || ["An unexpected error occurred while saving the loan simulation"]
    Rails.logger.error("Failed to save loan simulation: #{errors.join(', ')}")
    render json: { errors: errors }, status: :unprocessable_entity
  end

  def handle_argument_error(error)
    Rails.logger.error("ArgumentError encountered: #{error.message}")
    render json: { errors: ["Invalid parameters: #{error.message}"] }, status: :unprocessable_entity
  end
end
