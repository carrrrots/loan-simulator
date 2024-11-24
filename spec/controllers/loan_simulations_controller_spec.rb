require 'rails_helper'

RSpec.describe LoanSimulationsController, type: :controller do
  describe 'POST #create' do
    let(:valid_params) do
      { loan_amount: 10_000, birthdate: '1990-01-01', term_in_months: 12 }
    end

    let(:invalid_params) do
      { loan_amount: -10_000, birthdate: '', term_in_months: 0 }
    end

    let(:simulation_response) do
      {
        monthly_payment: 858.36,
        total_amount: 10_300.32,
        total_interest: 300.32
      }
    end

    before do
      allow_any_instance_of(LoanSimulationService).to receive(:perform).and_return(simulation_response)
      allow_any_instance_of(LoanSimulationRepository).to receive(:create).and_return(true)
    end

    context 'with valid parameters' do
      it 'returns a successful loan simulation' do
        post :create, params: valid_params

        expect(response).to have_http_status(:created)
        response_body = JSON.parse(response.body)
        expect(response_body).to include(
          'monthly_payment' => simulation_response[:monthly_payment],
          'total_amount' => simulation_response[:total_amount],
          'total_interest' => simulation_response[:total_interest]
        )
      end
    end

    context 'with invalid parameters' do
      before do
        allow_any_instance_of(LoanSimulationRepository).to receive(:create).and_return(false)
      end

      it 'returns an unprocessable entity status' do
        post :create, params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
        response_body = JSON.parse(response.body)
        expect(response_body).to include('errors')
      end
    end
  end
end
