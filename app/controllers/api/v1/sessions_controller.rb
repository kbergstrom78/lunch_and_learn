# frozen_string_literal: true

module Api
  module V1
    class SessionsController < ApplicationController
      skip_before_action :authenticate_request, only: [:create]

      def create
        user = User.find_by(email: session_params[:email])

        if user&.authenticate(session_params[:password])
          render json: {
            data: {
              type: 'user',
              id: user.id,
              attributes: {
                name: user.name,
                email: user.email,
                api_key: user.api_key
              }
            }
          }
        else
          render json: { error: 'Invalid credentials' }, status: :unauthorized
        end
      end

      private

      def session_params
        params.permit(:email, :password)
      end
    end
  end
end
