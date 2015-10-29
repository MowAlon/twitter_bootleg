require 'test_helper'

class HomeTimelineTest < ActiveSupport::TestCase

  def setup
    create_alon
    alon = User.find_by(name: "Alon Waisman")
    @twitter = alon.twitter
  end

  test "it can get 20 tweets from timeline" do
    VCR.use_cassette("twitter#home_timeline") do
      timeline = @twitter.home_timeline
      tweet = timeline.first

      assert_equal 20, timeline.count
      assert_equal Twitter::Tweet, tweet.class
    end
  end

  test "it gets all the info needed for a status listing" do
    VCR.use_cassette("twitter#home_timeline") do
      timeline = @twitter.home_timeline
      tweet = timeline.first

      assert_equal String, tweet.user.name.class
      assert_equal Fixnum, tweet.user.id.class
      assert_equal Addressable::URI, tweet.user.url.class
      assert_equal String, tweet.text.class
      assert       tweet.favorited? == true || tweet.favorited? == false
      assert_equal Fixnum, tweet.favorite_count.class
      assert       tweet.retweeted? == true || tweet.retweeted? == false
      assert_equal Fixnum, tweet.retweet_count.class
    end
  end

end
