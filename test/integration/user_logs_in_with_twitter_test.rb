require "test_helper"

class UserLogsInWithTwitterTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  def setup
    Capybara.app = TwitterBootleg::Application
    stub_omniauth
  end

  test "logging in" do
    visit "/"
    assert_equal 200, page.status_code
    click_link "Login"
    assert_equal "/profile", current_path
    save_and_open_page
    
    assert page.has_content?("Alon")
    assert page.has_link?("Logout")
  end

  def stub_omniauth
    # first, set OmniAuth to run in test mode
    OmniAuth.config.test_mode = true
    # then, provide a set of fake oauth data that
    # omniauth will use when a user tries to authenticate:
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      provider: 'twitter',
      extra: {
        raw_info: {
          user_id: "1234",
          name: "Alon",
          screen_name: "MowAlon",
        }
      },
      credentials: {
        token: "TimTam",
        secret: "TimTamSlam"
      }
    })
  end
end
