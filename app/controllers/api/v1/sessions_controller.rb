class Api::V1::SessionsController < ApplicationController
    def create
        user = User.find_by(name: params[:name])

        if user&.authenticate(params[:password])
            token = AuthenticationService.create_token(user)
            render json: { token: token, user_id: user.id}, status: :ok
        else
            render json: { message: "ログイン失敗"}, status: :unauthorized
        end
    end
end
