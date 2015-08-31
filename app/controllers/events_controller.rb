class EventsController < ApplicationController
  include SocialNetwork

  def index
  end

  def create
    if user_signed_in?
      if session[:signed_in_with] === 'facebook'
        fb_token = current_user.fb_oauth_token
        fb = FB.new(fb_token)
        fb.make_fb_post(params[:runner_id])
      elsif session[:signed_in_with] === 'vkontakte'
        vk_token = current_user.vk_oauth_token
        vk = VK.new(vk_token)
        vk.make_vk_post(params[:runner_id])
      end
    else
      redirect_to root_url, notice: "You need to sign in before continue"
    end
  end

  private

  def event_params
    params.require(:event).permit(:runner_id)
  end

end