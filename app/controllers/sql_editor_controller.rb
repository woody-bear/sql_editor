class SqlEditorController < ApplicationController
  
  def index
    query = params[:message]
    @result = ActiveRecord::Base.connection.exec_query(query)

    query_store = QueryStore.new()
    query_store.query = query
    query_store.save


    # debugger
    p @result
  end


  def query
    @querys_sended = QueryStore.all.limit(5)

    @tableInfos = ActiveRecord::Base.connection.exec_query('select * from information_schema.COLUMNS where TABLE_SCHEMA="briefly";')
    @databaseName =  ActiveRecord::Base.connection_config()[:database]

    @tables_connection = ActiveRecord::Base.connection.tables
    
    # @tables_2 =  ActiveRecord::Base.connection.tables.map{|table| {table_name: table, columns: get_columns_of_table(table)} }
    @tables =  ActiveRecord::Base.connection.tables.map{|table| {"#{table}": get_columns_of_table(table)} }
    # debugger
  end

  def get_columns_of_table(table_name)
    ActiveRecord::Base.connection.exec_query("select * from #{table_name}").columns
  end

end
