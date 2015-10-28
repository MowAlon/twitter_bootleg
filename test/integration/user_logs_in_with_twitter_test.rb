require "test_helper"

class UserLogsInWithTwitterTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  def setup
    Capybara.app = TwitterBootleg::Application
    stub_omniauth
  end

  test "logging in" do
    VCR.use_cassette("user_logs_in") do
      visit "/"
      assert_equal 200, page.status_code
      click_link "Login"
      assert_equal "/profile", current_path

      assert page.has_content?("Alon")
      assert page.has_link?("Logout")
    end
  end

  def stub_omniauth
    # First, set OmniAuth to run in test mode
    OmniAuth.config.test_mode = true
    # then, provide a set of fake oauth data that
    # omniauth will use when a user tries to authenticate:
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      provider: 'twitter',
      extra: {
        raw_info: {
          user_id: "150688890",
          name: "Alon Waisman",
          screen_name: "MowAlon",
        }
      },
      credentials: {
        token: ENV["alon_token"],
        secret: ENV["alon_secret"]
      }
    })
  end
end
