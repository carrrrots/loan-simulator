require 'rails_helper'

RSpec.describe Responses::LoanSimulationResponse do
  describe '#success?' do
    context 'when the response is successful' do
      let(:loan_simulation) do
        double(
          'LoanSimulation',
          loan_amount: 100_000.00,
          term_in_months: 24,
          birthdate: Date.new(1990, 5, 15),
          monthly_payment: 4_322.47,
          total_amount: 103_739.28,
          total_interest: 3_739.28
        )
      end

      subject do
        described_class.new(success: true, loan_simulation: loan_simulation)
      end

      it 'returns true for success?' do
        expect(subject.success?).to be true
      end

      it 'provides access to the loan simulation details' do
        expect(subject.loan_simulation).to eq(loan_simulation)
        expect(subject.loan_simulation.loan_amount).to eq(100_000.00)
        expect(subject.loan_simulation.total_interest).to eq(3_739.28)
      end

      it 'does not have an error message' do
        expect(subject.error).to be_nil
      end
    end

    context 'when the response is not successful' do
      let(:error_message) { 'Loan amount must be positive' }

      subject do
        described_class.new(success: false, error: error_message)
      end

      it 'returns false for success?' do
        expect(subject.success?).to be false
      end

      it 'provides access to the error message' do
        expect(subject.error).to eq('Loan amount must be positive')
      end

      it 'does not provide a loan simulation' do
        expect(subject.loan_simulation).to be_nil
      end
    end
  end
end
