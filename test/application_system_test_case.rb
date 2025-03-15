require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ]

  # Helper method to login as a user
  def login_and_visit(url)
    visit url
    fill_in "email_address", with: @user.email_address
    fill_in "password", with: "password"  # Password from fixtures
    click_on "Sign in"
  end
end
