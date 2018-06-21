require 'dotenv'
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV.fetch('TWITTWR_API_ID'), ENV.fetch('TWITTER_API_SECRET_KEY')
end
