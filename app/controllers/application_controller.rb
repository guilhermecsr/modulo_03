class ApplicationController < ActionController::Base
  before_action :set_locale

  def set_locale
    if params[:locale]
      cookies[:locale] = params[:locale]
    end

    if cookies[:locale]
      if I18n.locale != cookies[:locale]
        I18n.locale = cookies[:locale]
      end
    end
    # locale = params[:locale] || I18n.default_locale
    # I18n.with_locale(locale, &action)
  end
end
