require 'rails_helper'

RSpec.describe LoanSimulationService, type: :service do
  subject(:service) { described_class.new(params) }

  let(:params) { { loan_amount: loan_amount, birthdate: birthdate, term_in_months: term_in_months } }
  let(:loan_amount) { 100_000.00 }
  let(:birthdate) { '1990-01-01' }
  let(:term_in_months) { 24 }

  let(:age_calculator) { instance_double(AgeCalculator) }
  let(:interest_rate_calculator) { instance_double(InterestRateCalculator) }
  let(:payment_calculator) { instance_double(PaymentCalculator) }

  before do
    allow(AgeCalculator).to receive(:new).with(Date.parse(birthdate)).and_return(age_calculator)
    allow(InterestRateCalculator).to receive(:new).and_return(interest_rate_calculator)
    allow(PaymentCalculator).to receive(:new).and_return(payment_calculator)

    allow(age_calculator).to receive(:calculate).and_return(34) # Mock da idade
    allow(interest_rate_calculator).to receive(:calculate).with(34).and_return(0.03) # Mock da taxa de juros
    allow(payment_calculator).to receive(:calculate).and_return(4_298.12) # Mock do pagamento mensal
  end

  describe '#perform' do
    context 'when all parameters are valid' do
      it 'returns a successful response with correct loan simulation' do
        result = service.perform

        expect(result.success?).to be true

        loan_simulation = result.loan_simulation
        expect(loan_simulation.loan_amount).to eq(100_000.00)
        expect(loan_simulation.term_in_months).to eq(24)
        expect(loan_simulation.birthdate).to eq(Date.parse(birthdate))
        expect(loan_simulation.monthly_payment).to eq(4_298.12)
        expect(loan_simulation.total_amount).to eq(103_154.88)
        expect(loan_simulation.total_interest).to eq(3_154.88)
      end
    end

    context 'when parameters are invalid' do
      let(:loan_amount) { -1 }

      it 'returns an error response' do
        result = service.perform

        expect(result.success?).to be false
        expect(result.error).to eq('Loan amount must be a positive number')
      end
    end
  end
end
