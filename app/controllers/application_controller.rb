class ApplicationController < ActionController::Base
  include PublicActivity::StoreController

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :get_notifications

    protected

        def configure_permitted_parameters
            devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation) }
            devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :password_confirmation, :current_password) }
        end

  helper :all # Includes all custom helpers


  def after_sign_in_path_for(resource)
   # "/main" #your custom page
    root_path
  end

  def get_notifications
    if user_signed_in?
      @notifications = Notification.where(user_id: current_user.id, read: false).limit(10).order("created_at desc")
      @new_notifications = @notifications.where(new: true)
    end
  end



end
