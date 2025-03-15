require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
    @post = posts(:one)
  end

  test "visiting the index" do
    login_and_visit(topic_path(@post.topic))

    assert_selector "h2", text: "Posts"
    assert_selector "a", text: "New post"
  end

  test "should create post" do
    login_and_visit(topic_path(@post.topic))

    click_on "New post"

    fill_in "post[body]", with: "New Test Post Body"
    click_on "Create"

    assert_text "New Test Post Body"
  end

  test "should update Post" do
    login_and_visit(topic_path(@post.topic))

    click_on "Edit", id: "edit_#{dom_id(@post)}"

    fill_in "post[body]", with: "Updated Post Body"
    click_on "Update"

    assert_text "Updated Post Body"
  end

  test "should destroy Post" do
    login_and_visit(topic_path(@post.topic))

    accept_confirm do
      click_on "Delete", id: "delete_#{dom_id(@post)}"
    end

    assert_no_text @post.body
  end
end
