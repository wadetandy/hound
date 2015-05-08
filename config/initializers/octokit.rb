require 'octokit'

Octokit.configure do |c|
  c.api_endpoint = 'https://bbgithub.dev.bloomberg.com/api/v3'
  c.web_endpoint = 'https://bbgithub.dev.bloomberg.com'
  c.proxy = 'http://bproxy.cfe.bloomberg.com'
end

class Octokit::Client
  def user_teams(options = {})
    paginate "/api/v3/user/teams", options
  end
end
