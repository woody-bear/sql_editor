class CreateQueryStores < ActiveRecord::Migration[6.1]
  def change
    create_table :query_stores do |t|
      t.string :query, comment: '쿼리'
      t.timestamps
    end
  end
end
