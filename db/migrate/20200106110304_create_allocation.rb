class CreateAllocation < ActiveRecord::Migration[5.2]
  def change
    create_table :allocations, id: :uuid do |t|
      t.string :symbol
      t.integer :percentage
      t.timestamps
    end
  end
end
