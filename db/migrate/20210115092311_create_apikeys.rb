class CreateApikeys < ActiveRecord::Migration[6.0]
  def change
    create_table :apikeys do |t|
      t.integer :country_id
      t.string :apikey

      t.timestamps
    end
  end
end
