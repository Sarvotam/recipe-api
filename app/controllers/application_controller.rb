class ApplicationController < ActionController::API
	# before_action :authorized

	def encode_token(payload, exp = (Time.now + 86400).to_i)
    payload[:exp] = exp
    JWT.encode(payload, secret_key, 'HS256')
  end

  def auth_header
    # { Authorization: 'Bearer <token>' }
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]
      begin
        JWT.decode(token, secret_key, 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def logged_in_user
    if decoded_token
      user_id = decoded_token[0]['user_id']
      begin
      @user = User.find_by(id: user_id)
      rescue
      render json: { message: 'User not found' }
      end
    end
  end

  def logged_in?
    !!logged_in_user
  end

  def authorized
    if logged_in?
      @current_user = logged_in_user 
    else
      render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
    end
  end

  def secret_key
    secret = Rails.application.secrets.secret_key_base
  end

end
