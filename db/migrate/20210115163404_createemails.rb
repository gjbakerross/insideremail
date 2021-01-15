class Createemails < ActiveRecord::Migration[6.0]
  def change
    create_table :emails do |t|
      t.integer :country_id
      t.string :email

      t.timestamps
    end
  end
end
