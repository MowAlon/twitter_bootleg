class Status < OpenStruct

  def initialize(current_user)
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["twitter_api_key"]
      config.consumer_secret     = ENV["twitter_api_secret"]
      config.access_token        = current_user.oauth_token
      config.access_token_secret = current_user.oauth_token_secret
    end
  end

  def self.service
    @service ||= TwitterService.new
  end

  def all
    @client.home_timeline
  end


end
