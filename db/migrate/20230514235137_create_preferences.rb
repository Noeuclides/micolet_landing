class CreatePreferences < ActiveRecord::Migration[7.0]
  def change
    create_table :preferences do |t|

      t.timestamps
    end
  end
end
