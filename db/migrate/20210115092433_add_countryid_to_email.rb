class AddCountryidToEmail < ActiveRecord::Migration[6.0]
  def change
    add_column :emails, :country_id, :integer
    remove_column :emails, :country
  end
end
