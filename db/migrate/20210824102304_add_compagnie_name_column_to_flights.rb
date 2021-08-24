class AddCompagnieNameColumnToFlights < ActiveRecord::Migration[6.0]
  def change
    add_column :flights, :compagnie_name, :string
    add_column :flights, :airport_iata_code, :string
  end
end
