class ApplicationController < ActionController::Base
  include Authentication
  allow_browser versions: :modern
  include ActiveStorage::SetCurrent

  around_action :switch_locale

  private

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    if I18n.available_locales.map(&:to_s).include?(locale.to_s)
      I18n.with_locale(locale, &action)
    else
      flash.now[:notice] = "#{params[:locale]} translation not available"
      logger.error flash.now[:notice]
      I18n.with_locale(I18n.default_locale, &action)
    end
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
