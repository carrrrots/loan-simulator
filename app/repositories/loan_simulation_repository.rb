class LoanSimulationRepository
  def create(response)
    loan_simulation = response&.loan_simulation
    raise ArgumentError, "Invalid loan simulation: #{response.error}" unless loan_simulation

    loan_simulation.save!
    loan_simulation
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error("Failed to save loan simulation: #{loan_simulation.errors.full_messages.join(', ')}")
    raise ArgumentError, "Invalid loan simulation: #{loan_simulation.errors.full_messages.join(', ')}"
  end

  def find_by_id(id)
    LoanSimulation.find(id)
  end

  def find_all
    LoanSimulation.all
  end

  def update(loan_simulation, attributes)
    loan_simulation.update(attributes)
  end

  def delete(loan_simulation)
    loan_simulation.destroy
  end
end
