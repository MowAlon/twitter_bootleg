require 'test_helper'

class TwitterTest < ActiveSupport::TestCase

  def setup
    create_alon
  end

  test "it can connect and retrieve info from Twitter - use #current_user" do
    VCR.use_cassette("twitter#current_user") do
      alon = User.find_by(name: "Alon Waisman")
      screen_name = alon.screen_name

      current_user = alon.twitter.current_user

      assert_equal "Alon Waisman", current_user.name
      assert_equal screen_name, current_user.screen_name
    end
  end

end
