class User < ApplicationRecord
  def self.find_or_create_from_auth(auth)
    provider = auth[:provider]
    uid = auth[:uid]
    user_name = auth[:info][:user_name]
    consumer_key = auth.extra.access_token.consumer.key
    consumer_secret = auth.extra.access_token.consumer.secret
    token = auth.extra.access_token.token
    secret = auth.extra.access_token.secret

    self.find_or_create_by(provider: provider, uid: uid) do |user|
      user.user_name = user_name
      user.consumer_key = consumer_key
      user.consumer_secret = consumer_secret
      user.token = token
      user.secret = secret
    end
  end
end
