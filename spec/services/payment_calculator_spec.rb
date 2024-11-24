require 'rails_helper'

RSpec.describe PaymentCalculator, type: :service do
  describe '#calculate' do
    subject(:calculate) do
      described_class.new(
        loan_amount: loan_amount,
        term_in_months: term_in_months,
        interest_rate: interest_rate
      ).calculate
    end

    context 'when parameters are valid' do
      let(:loan_amount) { 10000 }
      let(:term_in_months) { 12 }
      let(:interest_rate) { 0.05 }

      it 'returns the correct monthly payment' do
        expect(calculate).to eq(856.07)
      end
    end

    context 'when loan amount is 0' do
      let(:loan_amount) { 0 }
      let(:term_in_months) { 12 }
      let(:interest_rate) { 0.00416667 }

      it 'raises an error' do
        expect { calculate }.to raise_error(ArgumentError).with_message('Loan amount must be a positive number')
      end
    end

    context 'when term in months is 0' do
      let(:loan_amount) { 10000 }
      let(:term_in_months) { 0 }
      let(:interest_rate) { 0.00416667 }

      it 'raises an error' do
        expect { calculate }.to raise_error(ArgumentError).with_message('Term in months must be a positive integer')
      end
    end
  end
end
