require "test_helper"

class UserFavoritingTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  def setup
    mowalontest
    reset_session!
    Capybara.app = TwitterBootleg::Application
    stub_omniauth
    @twitter = mowalontest.twitter
  end

  test "user favorites and unfavorites a tweet" do

    VCR.use_cassette("user_favorites_a_tweet") do
      visit "/"
      click_link "Login"
      assert_equal 200, page.status_code
      assert_equal profile_path, current_path

      tweet = @twitter.home_timeline.first
      refute tweet.favorited?

      click_link("favorite-#{tweet.id}")

      VCR.use_cassette("user_favorited_a_tweet") do
        tweet_after_favorite = @twitter.status(tweet.id)
        assert tweet_after_favorite.favorited?

        # visit profile_path
        # click_link("unfavorite-#{tweet.id}")
        #
        # VCR.use_cassette("user_unfavorited_a_tweet") do
        #   tweet_after_unfavorite = @twitter.status(tweet.id)
        #   refute tweet_after_unfavorite.favorited?
        # end

      end
    end
  end

end
