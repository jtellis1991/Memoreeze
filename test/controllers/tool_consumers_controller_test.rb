require "test_helper"

class ToolConsumersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tool_consumer = tool_consumers(:one)
  end

  test "should get index" do
    get tool_consumers_url
    assert_response :success
  end

  test "should get new" do
    get new_tool_consumer_url
    assert_response :success
  end

  test "should create tool_consumer" do
    assert_difference('ToolConsumer.count') do
      post tool_consumers_url, params: { tool_consumer: { guid: @tool_consumer.guid, name: @tool_consumer.name } }
    end

    assert_redirected_to tool_consumer_url(ToolConsumer.last)
  end

  test "should show tool_consumer" do
    get tool_consumer_url(@tool_consumer)
    assert_response :success
  end

  test "should get edit" do
    get edit_tool_consumer_url(@tool_consumer)
    assert_response :success
  end

  test "should update tool_consumer" do
    patch tool_consumer_url(@tool_consumer), params: { tool_consumer: { guid: @tool_consumer.guid, name: @tool_consumer.name } }
    assert_redirected_to tool_consumer_url(@tool_consumer)
  end

  test "should destroy tool_consumer" do
    assert_difference('ToolConsumer.count', -1) do
      delete tool_consumer_url(@tool_consumer)
    end

    assert_redirected_to tool_consumers_url
  end
end
