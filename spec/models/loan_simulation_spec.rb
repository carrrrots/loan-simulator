require 'rails_helper'

RSpec.describe LoanSimulation, type: :model do
  let(:valid_attributes) { { loan_amount: 10_000, birthdate: '1990-01-01', term_in_months: 12 } }

  it 'is valid with valid attributes' do
    simulation = described_class.new(valid_attributes)
    expect(simulation).to be_valid
  end

  it 'is invalid without a loan_amount' do
    simulation = described_class.new(valid_attributes.except(:loan_amount))
    expect(simulation).not_to be_valid
    expect(simulation.errors[:loan_amount]).to include("can't be blank")
  end

  it 'is invalid with a loan_amount less than or equal to zero' do
    simulation = described_class.new(valid_attributes.merge(loan_amount: -1))
    expect(simulation).not_to be_valid
    expect(simulation.errors[:loan_amount]).to include('must be greater than 0')
  end

  it 'is invalid without a birthdate' do
    simulation = described_class.new(valid_attributes.except(:birthdate))
    expect(simulation).not_to be_valid
    expect(simulation.errors[:birthdate]).to include("can't be blank")
  end

  it 'is invalid with a birthdate in the future' do
    simulation = described_class.new(valid_attributes.merge(birthdate: Date.tomorrow))
    expect(simulation).not_to be_valid
    expect(simulation.errors[:birthdate]).to include("can't be in the future")
  end

  it 'is invalid if the customer is a minor' do
    simulation = described_class.new(valid_attributes.merge(birthdate: Date.today - 17.years))
    expect(simulation).not_to be_valid
    expect(simulation.errors[:birthdate]).to include('indicates a minor, which is not allowed')
  end

  it 'is invalid without a term_in_months' do
    simulation = described_class.new(valid_attributes.except(:term_in_months))
    expect(simulation).not_to be_valid
    expect(simulation.errors[:term_in_months]).to include("can't be blank")
  end

  it 'is invalid with a term_in_months less than or equal to zero' do
    simulation = described_class.new(valid_attributes.merge(term_in_months: 0))
    expect(simulation).not_to be_valid
    expect(simulation.errors[:term_in_months]).to include('must be greater than 0')
  end
end
