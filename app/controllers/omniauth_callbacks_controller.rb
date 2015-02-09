class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all #Normally would be twitter, but since using multiple and code is similar, just calling it all.
    user = User.from_omniauth(request.env['omniauth.auth'])
    if user.persisted?
      #flash.notice = "Signed in!"
      sign_in_and_redirect user
    else
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_url
    end
  end
  alias_method :twitter, :all # I think I can put other ones here.
  alias_method :facebook, :all
  alias_method :google_oauth2, :all
end
