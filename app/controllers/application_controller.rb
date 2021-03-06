class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # search form params
  before_action { @sq = params.key?(:sq) ? params[:sq] : {} }
end
