class ApplicationController < ActionController::Base

  USERS = {"admin" => ENV['APP_PASSWORD']}

  http_basic_authenticate_with :name => ENV['BASIC_AUTH_USERNAME'], :password => ENV['BASIC_AUTH_PASSWORD'] if Rails.env == "production"
#  before_action :authenticate
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate
    authenticate_or_request_with_http_digest do |username|
      USERS[username]
    end
  end
end
