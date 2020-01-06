class CreatePortfolioState < ActiveRecord::Migration[5.2]
  def change
    create_table :portfolio_states, id: :uuid do |t|
      t.integer :initial_balance
      t.timestamps
    end
  end
end
