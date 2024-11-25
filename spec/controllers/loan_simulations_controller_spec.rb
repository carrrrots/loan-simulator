require 'rails_helper'

RSpec.describe LoanSimulationsController, type: :controller do
  describe 'GET #index' do
    let!(:simulations) { create_list(:loan_simulation, 3) }

    it 'returns all simulations' do
      get :index

      expect(response).to have_http_status(:ok)
      response_body = JSON.parse(response.body)
      expect(response_body.size).to eq(3)
    end
  end

  describe 'POST #create' do
    let(:valid_params) do
      { loan_simulation: { loan_amount: 100000, birthdate: '1990-01-01', term_in_months: 24 } }
    end

    let(:invalid_params) do
      { loan_simulation: { loan_amount: -10_000, birthdate: '', term_in_months: 0 } }
    end

    context 'with valid parameters' do
      let(:loan_simulation_service) { instance_double(LoanSimulationService) }
      let(:loan_simulation) do
        create(
          :loan_simulation,
          loan_amount: 1000,
          term_in_months: 12,
          birthdate: '1990-01-01',
          monthly_payment: 100,
          total_amount: 1200,
          total_interest: 200
        )
      end

      before do
        allow(LoanSimulationService).to receive(:new).and_return(loan_simulation_service)
        allow(loan_simulation_service).to receive(:perform).and_return(
          Responses::LoanSimulationResponse.new(
            success: true,
            loan_simulation: loan_simulation
          )
        )
      end

      it 'returns a successful loan simulation' do
        post :create, params: valid_params

        expect(response).to have_http_status(:created)
        response_body = JSON.parse(response.body)
        expect(response_body['loan_simulation']).to include('loan_amount', 'term_in_months', 'birthdate', 'monthly_payment', 'total_amount', 'total_interest')
      end
    end

    context 'with invalid parameters' do
      it 'returns an unprocessable entity status' do
        post :create, params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
        response_body = JSON.parse(response.body)
        expect(response_body).to include('errors')
      end
    end
  end
end
