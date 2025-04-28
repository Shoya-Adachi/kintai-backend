module Authenticate

    #トークンをデコードし、ユーザーを返す
    def current_user
      @current_user ||= authenticate_request
    end
  
    private
  
    #認証を強制
    def authenticate_request
      token = request.headers['Authorization']&.split(' ')&.last
      decoded = AuthenticationService.decode_token(token)
      if decoded
        User.find_by(id: decoded['user_id'])
      else
        nil
      end
    end
  
    # トークン認証が必要なAPIに「before_action :authenticate_user! 」を追加
    def authenticate_user!
      render json: { error: 'Not Authorized' }, status: :unauthorized unless current_user
    end
  end