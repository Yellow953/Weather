class CreateResults < ActiveRecord::Migration[7.0]
  def change
    create_table :results do |t|
      t.integer :key
      t.string :name
      t.string :text
      t.string :category
      t.integer :minimum
      t.integer :maximum
      t.integer :average

      t.timestamps
    end
  end
end
