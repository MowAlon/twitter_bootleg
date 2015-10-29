require 'test_helper'

class ProfileTest < ActiveSupport::TestCase

  def setup
    create_alon
    alon = User.find_by(name: "Alon Waisman")
    @twitter = alon.twitter
  end

  test "it gets all the info needed for the profile summary" do
    VCR.use_cassette("twitter#profile_summary") do
      logged_in_user = @twitter.user

      assert_equal String, logged_in_user.name.class
      assert_equal String, logged_in_user.screen_name.class
      assert_equal Addressable::URI, logged_in_user.url.class
      assert_equal Addressable::URI, logged_in_user.profile_image_url.class
      assert_equal Fixnum, logged_in_user.tweets_count.class
      assert_equal Fixnum, logged_in_user.friends_count.class
      assert_equal Fixnum, logged_in_user.followers_count.class
      assert_equal Twitter::Tweet, logged_in_user.status.class
      assert_equal Fixnum, logged_in_user.status.id.class
      assert_equal String, logged_in_user.description.class
      assert_equal String, logged_in_user.location.class
      assert_equal Addressable::URI, logged_in_user.website.class
      assert_equal Time, logged_in_user.created_at.class
    end
  end

end
