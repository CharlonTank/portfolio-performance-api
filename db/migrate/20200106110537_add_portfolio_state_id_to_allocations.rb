class AddPortfolioStateIdToAllocations < ActiveRecord::Migration[5.2]
  def change
    add_column :allocations, :portfolio_state_id, :uuid
  end
end
