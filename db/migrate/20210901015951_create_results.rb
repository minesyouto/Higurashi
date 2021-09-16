class CreateResults < ActiveRecord::Migration[5.2]
  def change
    create_table :results do |t|
      t.date :date
      t.integer :game
      t.integer :investment
      t.integer :collect
      t.integer :branch
      t.integer :success
      t.integer :total_branch
      t.integer :total_branch_success
      t.integer :user_id

      t.timestamps
    end
  end
end
