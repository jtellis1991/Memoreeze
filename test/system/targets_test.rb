require "application_system_test_case"

class TargetsTest < ApplicationSystemTestCase
  setup do
    @target = targets(:one)
  end

  test "visiting the index" do
    visit targets_url
    assert_selector "h1", text: "Targets"
  end

  test "creating a Target" do
    visit targets_url
    click_on "New Target"

    fill_in "Body", with: @target.body
    fill_in "Card", with: @target.card_id
    click_on "Create Target"

    assert_text "Target was successfully created"
    click_on "Back"
  end

  test "updating a Target" do
    visit targets_url
    click_on "Edit", match: :first

    fill_in "Body", with: @target.body
    fill_in "Card", with: @target.card_id
    click_on "Update Target"

    assert_text "Target was successfully updated"
    click_on "Back"
  end

  test "destroying a Target" do
    visit targets_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Target was successfully destroyed"
  end
end
