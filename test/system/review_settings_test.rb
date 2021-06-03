require "application_system_test_case"

class ReviewSettingsTest < ApplicationSystemTestCase
  setup do
    @review_setting = review_settings(:one)
  end

  test "visiting the index" do
    visit review_settings_url
    assert_selector "h1", text: "Review Settings"
  end

  test "creating a Review setting" do
    visit review_settings_url
    click_on "New Review Setting"

    fill_in "New per day", with: @review_setting.new_per_day
    fill_in "Reviews per day", with: @review_setting.reviews_per_day
    fill_in "User", with: @review_setting.user_id
    click_on "Create Review setting"

    assert_text "Review setting was successfully created"
    click_on "Back"
  end

  test "updating a Review setting" do
    visit review_settings_url
    click_on "Edit", match: :first

    fill_in "New per day", with: @review_setting.new_per_day
    fill_in "Reviews per day", with: @review_setting.reviews_per_day
    fill_in "User", with: @review_setting.user_id
    click_on "Update Review setting"

    assert_text "Review setting was successfully updated"
    click_on "Back"
  end

  test "destroying a Review setting" do
    visit review_settings_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Review setting was successfully destroyed"
  end
end
