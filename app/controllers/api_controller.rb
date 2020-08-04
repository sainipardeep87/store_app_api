# frozen_string_literal: true

# base class for api
class ApiController < ActionController::API
    include ActionController::HttpAuthentication::Token::ControllerMethods
  
    before_action :authorized_user
  
    rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found
    # rescue_from ::StandardError, with: :standerd_error
  
    respond_to :json
  
    protected
  
    def authorized_user
      return not_authrized if request.headers['Authorization'].blank?
      authenticate_with_http_token do |token, options|
        
        @current_user = User.where(auth_token: token)
        if @current_user.any?
         @current_user = @current_user.first
        else
          debugger
          return not_authrized
        end
       end
      
    end
  
  
    private
  
    def not_authrized
      render json: { message: 'You are not authorized to access this', status: 401 }
    end
  
    def record_not_found
      error = Errors::RecordNotFound.new
      render json: build_response({}, error.title, error.status)
    end
  
    def standerd_error
      error = Errors::StandardError.new
      render json: build_response({}, error.title, error.status)
    end
  end
  