class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authenticate_request

  attr_reader :current_user

  private

  def authenticate_request
    authenticate_or_request_with_http_token do |token, options|
      @current_user = User.find_by(api_key: token)
    end
  end
end