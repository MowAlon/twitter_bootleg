require "test_helper"

class UserRetweets < ActionDispatch::IntegrationTest
  include Capybara::DSL

  def setup
    mowalontest
    reset_session!
    Capybara.app = TwitterBootleg::Application
    stub_omniauth
    @twitter = mowalontest.twitter
  end

  test "user retweets a tweet" do

    VCR.use_cassette("user_retweets_a_tweet") do
      visit "/"
      click_link "Login"
      assert_equal 200, page.status_code
      assert_equal profile_path, current_path

      tweet = @twitter.home_timeline.first
      refute tweet.retweeted?

      click_link("retweet-#{tweet.id}")

      VCR.use_cassette("user_retweeted_a_tweet") do
        tweet_after_retweet = @twitter.status(tweet.id)
        assert tweet_after_retweet.retweeted?
      end
    end
  end

end
