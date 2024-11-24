require 'rails_helper'

RSpec.describe LoanSimulationValidator do
  describe '.validate!' do
    let(:valid_params) do
      {
        loan_amount: 100_000.00,
        term_in_months: 24,
        birthdate: Date.new(1990, 5, 15)
      }
    end

    context 'when all parameters are valid' do
      it 'does not raise any errors' do
        expect { described_class.validate!(valid_params) }.not_to raise_error
      end
    end

    context 'when loan_amount is invalid' do
      it 'raises an error if loan_amount is negative' do
        params = valid_params.merge(loan_amount: -10_000.00)
        expect { described_class.validate!(params) }.to raise_error(ArgumentError, 'Loan amount must be a positive number')
      end

      it 'raises an error if loan_amount is zero' do
        params = valid_params.merge(loan_amount: 0.00)
        expect { described_class.validate!(params) }.to raise_error(ArgumentError, 'Loan amount must be a positive number')
      end
    end

    context 'when term_in_months is invalid' do
      it 'raises an error if term_in_months is not a positive integer' do
        params = valid_params.merge(term_in_months: -12)
        expect { described_class.validate!(params) }.to raise_error(ArgumentError, 'Term in months must be a positive integer')
      end

      it 'raises an error if term_in_months is zero' do
        params = valid_params.merge(term_in_months: 0)
        expect { described_class.validate!(params) }.to raise_error(ArgumentError, 'Term in months must be a positive integer')
      end
    end

    context 'when birthdate is invalid' do
      it 'raises an error if birthdate is not a Date' do
        params = valid_params.merge(birthdate: '1990-05-15')
        expect { described_class.validate!(params) }.to raise_error(ArgumentError, 'Invalid birthdate')
      end
    end
  end
end
