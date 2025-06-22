class ApplicationController < ActionController::API
  private

  # Authorization header から JWT を取り出してユーザーを取得する
  def authenticate_user
    auth_header = request.headers['Authorization']
    return head :unauthorized unless auth_header.present?

    token = auth_header.split(' ').last
    begin
      payload, = JWT.decode(token, Rails.application.secret_key_base, true, algorithm: 'HS256')
      @current_user = User.find(payload['sub'])
    rescue StandardError
      return head :unauthorized
    end
  end
end
