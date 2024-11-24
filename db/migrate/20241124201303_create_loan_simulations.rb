class CreateLoanSimulations < ActiveRecord::Migration[6.1]
  def change
    create_table :loan_simulations do |t|
      t.decimal :loan_amount
      t.date :birthdate
      t.integer :term_in_months
      t.decimal :interest_rate
      t.decimal :monthly_payment
      t.decimal :total_amount
      t.decimal :total_interest

      t.timestamps
    end
  end
end
