require "test_helper"

class UserLogsOutTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  def setup
    mowalontest
    reset_session!
    Capybara.app = TwitterBootleg::Application
    stub_omniauth
  end

  test "logging out" do
    VCR.use_cassette("user_logs_in") do
      visit "/"
      click_link "Login"
      assert_equal "/profile", current_path
      click_link "Logout"

      assert_equal 200, page.status_code
      assert_equal root_path, current_path
      assert page.has_link?("Login")
      assert page.has_no_link?("Logout")
    end
  end

end
