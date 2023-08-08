class Api::V1::FavoritesController < ApplicationController
  before_action :find_user

  def index
    if @user.nil?
      render json: { error: "Invalid API key" }, status: 400
      return
    end

    favorites = @user.favorites
    render json: FavoriteSerializer.new(favorites), status: :ok
  end

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

  def destroy
    favorite = Favorite.find_by(id: params[:id], user_id: @user.id)

    if favorite
      favorite.destroy
      render json: { success: "Favorite deleted successfully" }, status: :ok
    else
      render json: { error: "Favorite not found" }, status: :not_found
    end
  end
  
  private

  def favorite_params
    params.require(:favorite).permit(:country, :recipe_link, :recipe_title)
  end

  def find_user
    @user = User.find_by(api_key: params[:api_key])
  end

  def render_error(message, status)
    render json: { error: message }, status: status
  end
end

