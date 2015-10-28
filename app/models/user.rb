class User < ActiveRecord::Base

  def self.from_omniauth(auth_info)
    user = User.first_or_create(uid: auth_info.uid)
    user.uid                = auth_info.uid
    user.name               = auth_info.extra.raw_info.name
    user.screen_name        = auth_info.extra.raw_info.screen_name
    user.oauth_token        = auth_info.credentials.token
    user.oauth_token_secret = auth_info.credentials.secret
    user.profile_image      = auth_info.info.image
    user.save
    user
  end

  def twitter
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["twitter_api_key"]
      config.consumer_secret     = ENV["twitter_api_secret"]
      config.access_token        = oauth_token
      config.access_token_secret = oauth_token_secret
    end
  end

end
