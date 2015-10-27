class TwitterService
  attr_reader :connection

  def initialize
    @connection = Hurley::Client.new("https://api.twitter.com/1.1")
  end

  def statuses
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["twitter_api_key"]
      config.consumer_secret     = ENV["twitter_api_secret"]
      config.access_token        = current_user.oauth_token
      config.access_token_secret = current_user.oauth_token_secret
    end

    client.friends.all
    # parse(connection.get('statuses/home_timeline.json', ))
  end

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end

end
