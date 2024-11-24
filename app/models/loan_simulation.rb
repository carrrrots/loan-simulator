class LoanSimulation < ApplicationRecord
  # Validações
  validates :loan_amount, numericality: { greater_than: 0 }, presence: true
  validates :term_in_months, numericality: { only_integer: true, greater_than: 0 }, presence: true
  validates :birthdate, presence: true
  validate :birthdate_cannot_be_in_the_future
  validate :birthdate_must_indicate_adult

  # Escopos
  scope :recent, -> { order(created_at: :desc) }

  private

  # Validação para impedir datas de nascimento no futuro
  def birthdate_cannot_be_in_the_future
    return if birthdate.blank?

    errors.add(:birthdate, "can't be in the future") if birthdate > Date.today
  end

  # Validação para garantir que o cliente é maior de idade
  def birthdate_must_indicate_adult
    return if birthdate.blank?

    age = Time.now.year - birthdate.year
    errors.add(:birthdate, 'indicates a minor, which is not allowed') if age < 18
  end
end
