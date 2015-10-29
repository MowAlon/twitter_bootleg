require 'test_helper'

class TwitterClientConnectionTest < ActiveSupport::TestCase

  def setup
    mowalontest
    @twitter = mowalontest.twitter
  end

  test "it can connect and retrieve info from Twitter - use #current_user" do
    VCR.use_cassette("twitter#current_user") do
      screen_name = mowalontest.screen_name
      logged_in_user = @twitter.user

      assert_equal "MowAlon Test", logged_in_user.name
      assert_equal screen_name, logged_in_user.screen_name
    end
  end

end
