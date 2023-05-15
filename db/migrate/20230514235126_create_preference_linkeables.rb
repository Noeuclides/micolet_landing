class CreatePreferenceLinkeables < ActiveRecord::Migration[7.0]
  def change
    create_table :preference_linkeables do |t|
      t.references :user, null: false, foreign_key: true
      t.references :preference, null: false, foreign_key: true

      t.timestamps
    end
  end
end
