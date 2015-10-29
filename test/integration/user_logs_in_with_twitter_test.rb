require "test_helper"

class UserLogsInWithTwitterTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  def setup
    reset_session!
    Capybara.app = TwitterBootleg::Application
    stub_omniauth
  end

  test "logging in" do
    VCR.use_cassette("user_logs_in") do
      visit "/"
      assert_equal 200, page.status_code
      click_link "Login"
      assert_equal profile_path, current_path

      assert page.has_content?("Alon")
      assert page.has_link?("Logout")
      assert page.has_no_link?("Login")
    end
  end

end
