Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_PROVIDER_KEY'], ENV['FACEBOOK_PROVIDER_SECRET'],
           {
               scope: 'manage_pages publish_pages publish_actions'
           }
  provider :vkontakte, ENV['VK_PROVIDER_KEY'], ENV['VK_PROVIDER_SECRET'],
           {
               # :scope => 'video,friends,audio,photos',
               :scope => 'wall, video, friends',
               :display => 'popup',
               :lang => 'en',
               :image_size => 'original'
           }
end
