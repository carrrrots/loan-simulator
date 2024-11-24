require 'rails_helper'

RSpec.describe AgeCalculator, type: :service do
  describe '#calculate' do
    let(:calculator) { described_class.new(birthdate) }

    context 'when the birth date is a date' do
      let(:birthdate) { Date.parse('1990-01-01') }
      before do
        allow(Time.zone).to receive(:now).and_return(Time.zone.local(2024, 11, 23))
      end
      it 'returns the correct age' do
        age = calculator.calculate

        expect(age).to eq(34)
      end
    end

    context 'when the birth date is not a date' do
      let(:birthdate) { '1990-01-01' }

      before do
        allow(calculator).to receive(:validate_date).and_raise(ArgumentError, 'Invalid date')
      end

      it 'raises an error' do
        expect { calculator.calculate }.to raise_error(ArgumentError, 'Invalid date')
      end
    end

    context 'when the birth date is nil' do
      let(:birthdate) { nil }

      it 'raises an error' do
        expect { calculator.calculate }.to raise_error(ArgumentError, 'Invalid date')
      end
    end

    context 'when adding a year' do
      let(:birthdate) { Date.parse('1990-12-31') }
       before do
        allow(Time.zone).to receive(:now).and_return(Time.zone.local(2024, 11, 23))
       end
      it 'returns the correct age' do
        age = calculator.calculate

        expect(age).to eq(33)
      end
    end
  end
end
