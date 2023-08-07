class Api::V1::FavoritesController < ApplicationController
  before_action :find_user

  def create
    if @user.nil?
      render json: { error: "Unauthorized request" }, status: :bad_request
    else
      favorite = Favorite.new(favorite_params)
      favorite.user_id = @user.id
      if favorite.save
        render json: { success: "Favorite added successfully" }, status: :created
      else
        render_error(favorite.errors.full_messages.to_sentence, :unprocessable_entity)
      end
    end
  end

  private

  def favorite_params
    params.permit(:country, :recipe_link, :recipe_title)
  end

  def find_user
    @user = User.find_by(api_key: params[:api_key])
  end
end

