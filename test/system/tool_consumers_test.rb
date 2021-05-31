require "application_system_test_case"

class ToolConsumersTest < ApplicationSystemTestCase
  setup do
    @tool_consumer = tool_consumers(:one)
  end

  test "visiting the index" do
    visit tool_consumers_url
    assert_selector "h1", text: "Tool Consumers"
  end

  test "creating a Tool consumer" do
    visit tool_consumers_url
    click_on "New Tool Consumer"

    fill_in "Guid", with: @tool_consumer.guid
    fill_in "Name", with: @tool_consumer.name
    click_on "Create Tool consumer"

    assert_text "Tool consumer was successfully created"
    click_on "Back"
  end

  test "updating a Tool consumer" do
    visit tool_consumers_url
    click_on "Edit", match: :first

    fill_in "Guid", with: @tool_consumer.guid
    fill_in "Name", with: @tool_consumer.name
    click_on "Update Tool consumer"

    assert_text "Tool consumer was successfully updated"
    click_on "Back"
  end

  test "destroying a Tool consumer" do
    visit tool_consumers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Tool consumer was successfully destroyed"
  end
end
