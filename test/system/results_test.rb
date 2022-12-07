require "application_system_test_case"

class ResultsTest < ApplicationSystemTestCase
  setup do
    @result = results(:one)
  end

  test "visiting the index" do
    visit results_url
    assert_selector "h1", text: "Results"
  end

  test "should create result" do
    visit results_url
    click_on "New result"

    fill_in "Average", with: @result.average
    fill_in "Category", with: @result.category
    fill_in "Key", with: @result.key
    fill_in "Maximum", with: @result.maximum
    fill_in "Minimum", with: @result.minimum
    fill_in "Name", with: @result.name
    fill_in "Text", with: @result.text
    click_on "Create Result"

    assert_text "Result was successfully created"
    click_on "Back"
  end

  test "should update Result" do
    visit result_url(@result)
    click_on "Edit this result", match: :first

    fill_in "Average", with: @result.average
    fill_in "Category", with: @result.category
    fill_in "Key", with: @result.key
    fill_in "Maximum", with: @result.maximum
    fill_in "Minimum", with: @result.minimum
    fill_in "Name", with: @result.name
    fill_in "Text", with: @result.text
    click_on "Update Result"

    assert_text "Result was successfully updated"
    click_on "Back"
  end

  test "should destroy Result" do
    visit result_url(@result)
    click_on "Destroy this result", match: :first

    assert_text "Result was successfully destroyed"
  end
end
