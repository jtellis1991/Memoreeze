require "application_system_test_case"

class GradesTest < ApplicationSystemTestCase
  setup do
    @grade = grades(:one)
  end

  test "visiting the index" do
    visit grades_url
    assert_selector "h1", text: "Grades"
  end

  test "creating a Grade" do
    visit grades_url
    click_on "New Grade"

    fill_in "Assignment", with: @grade.assignment_id
    fill_in "Deck", with: @grade.deck_id
    fill_in "Enrollment", with: @grade.enrollment_id
    fill_in "Score", with: @grade.score
    click_on "Create Grade"

    assert_text "Grade was successfully created"
    click_on "Back"
  end

  test "updating a Grade" do
    visit grades_url
    click_on "Edit", match: :first

    fill_in "Assignment", with: @grade.assignment_id
    fill_in "Deck", with: @grade.deck_id
    fill_in "Enrollment", with: @grade.enrollment_id
    fill_in "Score", with: @grade.score
    click_on "Update Grade"

    assert_text "Grade was successfully updated"
    click_on "Back"
  end

  test "destroying a Grade" do
    visit grades_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Grade was successfully destroyed"
  end
end
