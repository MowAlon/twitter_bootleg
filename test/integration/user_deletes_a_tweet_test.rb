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

  test "user deletes a tweet" do

    VCR.use_cassette("user_deletes_a_tweet") do
      visit "/"
      click_link "Login"
      assert_equal 200, page.status_code
      assert_equal profile_path, current_path

      user = @twitter.user
      status_before_delete = user.status
      assert_equal Twitter::Tweet, status_before_delete.class
      tweet_count_before_delete = user.tweets_count
      assert_equal Fixnum, tweet_count_before_delete.class

      click_link("delete-status")

      VCR.use_cassette("user_deleted_a_tweet") do
  binding.pry
        status_after_delete = @twitter.user.status
        assert_equal Twitter::Tweet, status_after_delete.class
        tweet_count_after_delete = @twitter.user.tweets_count
        assert_equal Fixnum, tweet_count_after_delete.class

        refute status_before_delete == status_after_delete
        assert_equal tweet_count_before_delete - 1, tweet_count_after_delete
      end
    end
  end

end
