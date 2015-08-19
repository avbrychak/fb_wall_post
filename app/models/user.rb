class User < ActiveRecord::Base

	has_many :events

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      if auth['info']
         user.name = auth['info']['name'] || ""
      end
    end
  end

  def create_event(event_params)
    self.events.create(event_params)
  end

  def facebook
  	@facebook ||= Koala::Facebook::API.new(oauth_token)  
  end 
end
