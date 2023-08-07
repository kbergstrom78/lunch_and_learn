class ApplicationController < ActionController::API
  before_action :authenticate_request

  attr_reader :current_user

  private

  def authenticate_request
    api_key = params[:api_key]
    @current_user = User.find_by(api_key: api_key)
  end
  
  def render_error(message, status)
    render json: { error: message }, status: status
  end
end
