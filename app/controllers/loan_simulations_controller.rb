class LoanSimulationsController < ApplicationController
  def index
    simulations = LoanSimulation.all
    render json: simulations.map(&:as_json), status: :ok
  end

  def create
    loan_simulation = build_loan_simulation

    if save_loan_simulation(loan_simulation)
      render json: loan_simulation.to_json, status: :created
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
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error("Failed to save loan simulation: #{loan_simulation.errors}")
    false
  end

  def loan_simulation_params
    params.require(:loan_simulation).permit(:loan_amount, :term_in_months, :birthdate)
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
