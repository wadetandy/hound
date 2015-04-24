Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :github,
    ENV['GITHUB_CLIENT_ID'],
    ENV['GITHUB_CLIENT_SECRET'],
    # client_options: {
    #   site: 'https://bbgithub.dev.bloomberg.com/api/v3',
    #   authorize_url: 'https://bbithub.dev.bloomberg.com/login/oauth/authorize',
    #   token_url: 'https://bbithub.dev.bloomberg.com/login/oauth/access_token'
    # },
    scope: 'user:email,repo'
  )
end
