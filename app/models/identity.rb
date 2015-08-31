class Identity < ActiveRecord::Base
  belongs_to :user

  scope :fb_identity, ->(){where('provider = ?', 'facebook')}
  scope :vk_identity, ->(){where('provider =?', 'vkontakte')}

  class << self
    def find_with_omniauth(auth)
      find_by(uid: auth['uid'], provider: auth['provider'])
    end

    def create_with_omniauth(auth)
      create! do |identity|
        identity.uid = auth['uid']
        identity.provider = auth['provider']
        identity.oauth_token = auth.credentials.token
        identity.oauth_expires_at = Time.at(auth.credentials.expires_at)
      end
    end
  end

  def has_any_user?
    !self.user.nil?
  end

  def create_user (attrs = {})
    self.create_user!(attrs)
  end

end

