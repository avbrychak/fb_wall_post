class User < ActiveRecord::Base
  has_many :identities, dependent: :destroy

  def fb_oauth_token
    identities.fb_identity.first.oauth_token
  end

  def vk_oauth_token
    identities.vk_identity.first.oauth_token
  end
end
