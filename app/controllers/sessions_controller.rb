class SessionsController < ApplicationController

  def facebook
    redirect_to '/auth/facebook'
  end

  def vkontakte
    redirect_to '/auth/vkontakte'
  end

  def create
    auth = request.env["omniauth.auth"]
    identity = Identity.find_with_omniauth(auth)
    if identity.nil?
      identity = Identity.create_with_omniauth(auth)
    end
    reset_session
    if identity.user.present?
      session[:user_id] = identity.user_id
      session[:signed_in_with] = identity.provider
      redirect_to events_url, :notice => 'Signed in!'
    else
      if auth['info']
        user_name = auth['info']['name'] || ""
        identity.create_user(name: user_name)
        identity.save
      end
      session[:user_id] = identity.user_id
      session[:signed_in_with] = identity.provider
      redirect_to events_url, notice: 'Linked your account and Signed in!'
    end
  end

  def destroy
    reset_session
    redirect_to root_url, :notice => 'Signed out!'
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end

end
