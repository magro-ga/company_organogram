class CreateEmployees < ActiveRecord::Migration[8.0]
  def change
    create_table :employees do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.references :company, null: false, foreign_key: true
      t.references :manager, foreign_key: { to_table: :employees }

      t.timestamps
    end

    add_index :employees, :email, unique: true
  end
end
