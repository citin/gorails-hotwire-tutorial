require "application_system_test_case"

class TopicsTest < ApplicationSystemTestCase
  setup do
    @topic = topics(:one)
    @user = users(:one)
  end

  test "visiting the index" do
    login_and_visit(topics_url)

    assert_selector "h1", text: "Topics"
    assert_selector "a", text: "New topic"
  end

  test "should create topic" do
    login_and_visit(topics_url)

    # Now continue with topic creation
    click_on "New topic"

    fill_in "topic[name]", with: "New Test Topic"
    click_on "Create"

    assert_text "New Test Topic"
  end

  test "should show topic" do
    login_and_visit(topics_url)

    click_on "View", id: "show_#{dom_id(@topic)}"

    assert_selector "h1", text: @topic.name
    assert_selector "a", text: "Back to topics"
    assert_selector "a", text: "New post"
  end

  test "should destroy topic" do
    login_and_visit(topics_url)

    # Find the topic's container and click the delete button within it
    accept_confirm do
      click_on "Delete", id: "delete_#{dom_id(@topic)}"
    end

    assert_no_text @topic.name
  end
end
