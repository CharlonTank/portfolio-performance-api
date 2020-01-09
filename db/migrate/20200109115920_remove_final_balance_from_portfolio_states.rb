class RemoveFinalBalanceFromPortfolioStates < ActiveRecord::Migration[6.0]
  def change
    remove_column :portfolio_states, :final_balance
  end
end
