require 'rails_helper'

RSpec.describe LoanSimulationRepository do
  let(:repository) { described_class.new }
  let(:loan_simulation) { build(:loan_simulation) }
  let(:response_class) { double('ResponseClass') }

  let(:response) do
    double(
      success: true,
      loan_simulation: loan_simulation
    )
  end

  describe '#create' do
    context 'with valid attributes' do

      before do
        allow(response).to receive(:new).with(sucess: true, loan_simulation: loan_simulation).and_return(response)
      end

      it 'saves a valid loan simulation' do
        expect(repository.create(response)).to eq(loan_simulation)
        expect(loan_simulation).to be_persisted
      end
    end

    context 'with invalid attributes' do
      let(:invalid_loan_simulation) { build(:loan_simulation, loan_amount: -100000) }
      let(:invalid_response) do
        double(
          success: false,
          loan_simulation: invalid_loan_simulation
        )
      end

      before do
        allow(repository).to receive(:create).with(invalid_response).and_raise(
          ArgumentError, "Invalid loan simulation: Loan amount must be greater than 0"
        )
        allow(invalid_loan_simulation).to receive_message_chain(:errors, :full_messages).and_return(["Loan amount must be greater than 0"])
      end

      it 'raises an ArgumentError with detailed messages' do
        expect {
          repository.create(invalid_response)
        }.to raise_error(ArgumentError, "Invalid loan simulation: Loan amount must be greater than 0")
      end
    end
  end
end
