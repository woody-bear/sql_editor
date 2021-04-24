class CreateAddFieldToQueryStores < ActiveRecord::Migration[6.1]
  def change
    create_table :add_field_to_query_stores do |t|
      add_column :query_stores, :response_json_data, :string, comment: "결과값"
      t.timestamps
    end
  end
end
