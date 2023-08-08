class ApplicationController < ActionController::API
  before_action :authenticate_request

  attr_reader :current_user

  private

  def authenticate_request
    @user = User.find_by(api_key: params[:api_key])
    render json: { error: "Invalid API key" }, status: :bad_request if @user.nil?
  end
end