class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]

  def create
    user = User.new(user_params)

    if User.exists?(email: user.email)
      render json: { error: 'Email has already been taken' }, status: :unprocessable_entity
    elsif user.save
      render json: UserSerializer.new(user), status: :created
    else
      render json: { error: user.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end