module Api
  module V1
    class SessionsController < ApplicationController
      skip_before_action :authenticate_user

      def create
        user = User.find_by(email: params[:email])
        if user&.authenticate(params[:password])
          token = JWT.encode({ sub: user.id }, Rails.application.secret_key_base, 'HS256')
          render json: { token: token }, status: :created
        else
          head :unauthorized
        end
      end
    end
  end
end
