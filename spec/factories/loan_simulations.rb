FactoryBot.define do
  factory :loan_simulation do
    loan_amount { 10_000 }
    birthdate { Date.new(1990, 1, 1) }
    term_in_months { 12 } # Em meses
    interest_rate { 0.03 } # Taxa de juros anual
    monthly_payment { 858.36 }
    total_amount { 10_300.32 }
    total_interest { 300.32 }

    # Trait para simulações com idade jovem (até 25 anos)
    trait :young_age do
      birthdate { Date.today - 20.years }
      interest_rate { 0.05 }
      monthly_payment { 875.87 }
      total_amount { 10_510.44 }
      total_interest { 510.44 }
    end

    # Trait para simulações com idade média (26 a 40 anos)
    trait :middle_age do
      birthdate { Date.today - 30.years }
      interest_rate { 0.03 }
      monthly_payment { 858.36 }
      total_amount { 10_300.32 }
      total_interest { 300.32 }
    end

    # Trait para simulações com idade madura (41 a 60 anos)
    trait :mature_age do
      birthdate { Date.today - 50.years }
      interest_rate { 0.02 }
      monthly_payment { 850.00 }
      total_amount { 10_200.00 }
      total_interest { 200.00 }
    end

    # Trait para simulações com idade acima de 60 anos
    trait :senior_age do
      birthdate { Date.today - 65.years }
      interest_rate { 0.04 }
      monthly_payment { 866.67 }
      total_amount { 10_400.00 }
      total_interest { 400.00 }
    end

    # Trait para valores de empréstimo pequenos
    trait :small_loan do
      loan_amount { 1_000 }
      monthly_payment { 85.84 }
      total_amount { 1_030.08 }
      total_interest { 30.08 }
    end

    # Trait para valores de empréstimo médios
    trait :medium_loan do
      loan_amount { 50_000 }
      monthly_payment { 4_291.80 }
      total_amount { 51_501.60 }
      total_interest { 1_501.60 }
    end

    # Trait para valores de empréstimo altos
    trait :large_loan do
      loan_amount { 1_000_000 }
      monthly_payment { 85_836.00 }
      total_amount { 1_030_032.00 }
      total_interest { 30_032.00 }
    end

    # Trait para prazos curtos
    trait :short_term do
      term_in_months { 6 }
      monthly_payment { 1_700.00 }
      total_amount { 10_200.00 }
      total_interest { 200.00 }
    end

    # Trait para prazos médios
    trait :medium_term do
      term_in_months { 24 }
      monthly_payment { 441.00 }
      total_amount { 10_584.00 }
      total_interest { 584.00 }
    end

    # Trait para prazos longos
    trait :long_term do
      term_in_months { 60 }
      monthly_payment { 184.17 }
      total_amount { 11_050.00 }
      total_interest { 1_050.00 }
    end

    # Trait para criar simulações com todos os valores extremos
    trait :extreme_values do
      loan_amount { 10_000_000 }
      term_in_months { 240 }
      birthdate { Date.today - 70.years }
      interest_rate { 0.04 }
      monthly_payment { 60_000.00 }
      total_amount { 14_400_000.00 }
      total_interest { 4_400_000.00 }
    end
  end
end
