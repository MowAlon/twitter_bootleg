require 'test_helper'

class TwitterTest < ActiveSupport::TestCase

  test "it can connect and retrieve info from Twitter - use #current_user" do
    alon = User.find_by(name: "Alon Waisman")
    screen_name = alon.screen_name

    assert_equal "Alon Waisman", alon.twitter.current_user.name
    assert_equal "MowAlon", alon.twitter.current_user.screen_name
  end
  
end
