require "test_helper"

class SqlEditorControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get sql_editor_index_url
    assert_response :success
  end

  test "should get search" do
    get sql_editor_search_url
    assert_response :success
  end
end
