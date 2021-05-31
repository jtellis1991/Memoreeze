require "test_helper"

class ReviewSettingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @review_setting = review_settings(:one)
  end

  test "should get index" do
    get review_settings_url
    assert_response :success
  end

  test "should get new" do
    get new_review_setting_url
    assert_response :success
  end

  test "should create review_setting" do
    assert_difference('ReviewSetting.count') do
      post review_settings_url, params: { review_setting: { new_per_day: @review_setting.new_per_day, reviews_per_day: @review_setting.reviews_per_day, user_id: @review_setting.user_id } }
    end

    assert_redirected_to review_setting_url(ReviewSetting.last)
  end

  test "should show review_setting" do
    get review_setting_url(@review_setting)
    assert_response :success
  end

  test "should get edit" do
    get edit_review_setting_url(@review_setting)
    assert_response :success
  end

  test "should update review_setting" do
    patch review_setting_url(@review_setting), params: { review_setting: { new_per_day: @review_setting.new_per_day, reviews_per_day: @review_setting.reviews_per_day, user_id: @review_setting.user_id } }
    assert_redirected_to review_setting_url(@review_setting)
  end

  test "should destroy review_setting" do
    assert_difference('ReviewSetting.count', -1) do
      delete review_setting_url(@review_setting)
    end

    assert_redirected_to review_settings_url
  end
end
