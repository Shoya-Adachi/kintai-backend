class AuthenticationService
    HMAC_SECRET = Rails.application.credentials.secret_key_base

    # トークン発行
    def self.create_token(user)
        payload = {user_id: user.id}
        JWT.encode(payload, HMAC_SECRET, 'HS256')
    end

    # トークンをデコード（解析）して検証
    def self.decode_token(token)
        begin
          JWT.decode(token, HMAC_SECRET, true, { algorithm: 'HS256' }).first
        rescue JWT::DecodeError
          nil
        end
    end
end
