require 'rails_helper'

RSpec.describe InterestRateCalculator, type: :service do
  describe '#calculate' do
    subject(:calculator) { described_class.new }

    context 'when age is less than or equal to 25' do
      it 'returns 0.05' do
        expect(calculator.calculate(25)).to eq(0.05)
      end
    end

    context 'when age is between 26 and 40' do
      it 'returns 0.03' do
        expect(calculator.calculate(30)).to eq(0.03)
        expect(calculator.calculate(40)).to eq(0.03)
      end
    end

    context 'when age is between 41 and 60' do
      it 'returns 0.02' do
        expect(calculator.calculate(50)).to eq(0.02)
        expect(calculator.calculate(60)).to eq(0.02)
      end
    end

    context 'when age is greater than 60' do
      it 'returns 0.04' do
        expect(calculator.calculate(70)).to eq(0.04)
        expect(calculator.calculate(80)).to eq(0.04)
      end
    end

    context 'when age is not a positive integer' do
      it 'raises an ArgumentError for non-integer' do
        expect { calculator.calculate('thirty') }.to raise_error(ArgumentError, 'Age must be a positive integer')
        expect { calculator.calculate(nil) }.to raise_error(ArgumentError, 'Age must be a positive integer')
      end

      it 'raises an ArgumentError for negative values' do
        expect { calculator.calculate(-5) }.to raise_error(ArgumentError, 'Age must be a positive integer')
      end
    end
  end
end
