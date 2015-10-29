module ApplicationHelper
  include Twitter::Autolink

  def twitter_links(status)
    sanitize(auto_link(status))
  end
end
