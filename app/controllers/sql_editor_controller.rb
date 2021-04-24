class SqlEditorController < ApplicationController
  
  def index

    query = params[:message]
    response = RestClient.post 'https://data.stackexchange.com/query/save/1', {title: '', description: '', sql: query}

    # job_id 없이 결과값이 넘어오는 경우 체크해서 결과 표시
    if JSON.parse(response.body)["resultSets"].present?
      @result = JSON.parse(response.body)["resultSets"]
      p @result
    end

    # 캡챠 인중후 running true
    if JSON.parse(response.body)["running"] == true
      job_id = JSON.parse(response.body)["job_id"]
      # debugger
      begin
        # debugger
        result = RestClient.get "https://data.stackexchange.com/query/job/#{job_id}"
        
        # debugger
        @result = JSON.parse(result)["resultSets"]
        
        # result 디비에 저장하려고 하면 rollback 되는 문제 ( 차이점 비교를 위한 작업 )
        # query_store = QueryStore.new()
        # query_store.query = query
        # query_store.response_json_data = @result
        # # # # debugger
        # query_store.save
        # debugger
        p @result
      rescue StandardError => e
        return render json: {:error => e}, status: :bad_request
      end
    end  
    
    # 캡챠 인증이 필요한 순간 노티 뿌려주기
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
