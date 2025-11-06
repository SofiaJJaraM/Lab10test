class ApplicationController < ActionController::Base
  include CanCan::ControllerAdditions
  allow_browser versions: :modern

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message.presence || "No estás autorizado para realizar esa acción."
  end
end
