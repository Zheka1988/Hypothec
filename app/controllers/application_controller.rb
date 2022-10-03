class ApplicationController < ActionController::Base
  before_action :set_locale

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html { redirect_to root_url, alert: current_user ? "#{current_user.email.split('@').first}, " + exception.message.downcase : exception.message }
    end
  end

  private
  def set_locale
    I18n.locale = I18n.locale_available?(params[:lang]) || I18n.default_locale
  end
end
