# Loan Simulation API

This project provides a Loan Simulation Service for calculating and managing loan simulations. The application uses Ruby on Rails and Docker for containerized deployment.

## Requirements

Ensure the following tools are installed on your machine:

Docker: [Docker Install](https://docs.docker.com/get-docker/)
Docker Compose: Included with Docker Desktop or install separately if needed.

## Setup and Run Instructions

### 1. Clone the Repository

<!-- ```bash -->
git clone git@github.com:carrrrots/loan-simulator.git
cd loan-simulator

### 2. Build the Docker Containers
docker-compose up --build

### 3. Setup the Database
docker-compose exec --rm app rails db:create db:migrate

### 4. Start the Application
docker-compose up

A aplicação estará disponível em [localhost](http://localhost:3000).

### 5. Access the Application
- [Swagger (API Documentation)](http://localhost:3000/api-docs)
  - This interactive documentation allows you to explore and test API endpoints.
  - Swagger UI provides details about the available routes, required parameters, and response formats.

- API Endpoints: Access directly at [localhost](http://localhost:3000)

### 6. Testes
docker-compose exec --rm app bundle exec rspec
<!-- docker-compose run --rm -e RAILS_ENV=test app bundle exec rspec -->

### 7. Endpoints
GET /loan_simulations
Retrieves a list of all saved loan simulations.
Parameters: None.
Success Response (200):
[
  {
    "id": 1,
    "loan_amount": 10000.0,
    "term_in_months": 12,
    "birthdate": "1990-01-01",
    "interest_rate": 0.03,
    "monthly_payment": 858.33,
    "total_amount": 10300.0,
    "total_interest": 300.0,
    "created_at": "2024-11-24T00:00:00Z",
    "updated_at": "2024-11-24T00:00:00Z"
  }
]

POST /loan_simulations:
Create a new loan simulation.

Request Body Parameters:
- loan_amount (decimal): Loan amount (required, greater than 0).
- term_in_months (integer): Number of months for repayment (required, greater than 0).
- birthdate (date): Applicant's birthdate (required, format YYYY-MM-DD).

Example Request:
through curl:
curl -X POST http://localhost:3000/loan_simulations \
-H "Content-Type: application/json" \
-d '{
  "loan_amount": 10000,
  "birthdate": "1990-05-15",
  "term_in_months": 24
}'

or through terminal:
{
  "loan_simulation": {
    "loan_amount": 15000,
    "term_in_months": 24,
    "birthdate": "1985-05-20"
  }
}

Success Response (201):
{
  "id": 2,
  "loan_amount": 15000.0,
  "term_in_months": 24,
  "birthdate": "1985-05-20",
  "interest_rate": 0.03,
  "monthly_payment": 643.86,
  "total_amount": 15452.64,
  "total_interest": 452.64,
  "created_at": "2024-11-24T00:00:00Z",
  "updated_at": "2024-11-24T00:00:00Z"
}

Possible Errors:
  - 422 Unprocessable Entity: Invalid parameters or missing data.
  - Example Error Response:
  {
    "errors": ["Loan amount must be a positive number"]
  }

### 8. Estrutura de Diretórios:
- app/controllers: Contains controllers responsible for managing HTTP requests and responses.
- app/models: Houses Active Record models, which represent and validate database records.
- app/services: Contains business logic and reusable components that perform calculations and other complex operations.
- app/validators: Includes custom validation logic used throughout the application.
- app/repositories: Abstração para interação com o banco de dados.
- app/specs: Contains unit and integration tests for the application to ensure its reliability.
