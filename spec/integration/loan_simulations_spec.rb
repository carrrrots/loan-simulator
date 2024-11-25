require 'swagger_helper'

RSpec.describe 'loan_simulations', type: :request do
  path '/loan_simulations' do
    get('list loan simulations') do
      tags 'Loan Simulations'
      produces 'application/json'

      response(200, 'successful') do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   loan_amount: { type: :number },
                   term_in_months: { type: :integer },
                   monthly_payment: { type: :number }
                 },
                 required: %w[id loan_amount term_in_months monthly_payment]
               }

        before do
          create_list(:loan_simulation, 3, loan_amount: 10_000, term_in_months: 12)
        end

        run_test! do |response|
          body = JSON.parse(response.body)
          expect(body.size).to eq(3)
        end
      end
    end

    post('create a loan simulation') do
      tags 'Loan Simulations'
      consumes 'application/json'
      parameter name: :loan_simulation, in: :body, schema: {
        type: :object,
        properties: {
          loan_amount: { type: :number },
          birthdate: { type: :string, format: :date },
          term_in_months: { type: :integer }
        },
        required: %w[loan_amount birthdate term_in_months]
      }

      response(201, 'created') do
        let(:loan_simulation) { { loan_amount: 10_000, birthdate: '1990-01-01', term_in_months: 12 } }
        run_test!
      end

      response(422, 'unprocessable entity') do
        let(:loan_simulation) { { loan_amount: -10_000, birthdate: '', term_in_months: 0 } }
        run_test!
      end
    end
  end
end
