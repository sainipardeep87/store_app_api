# frozen_string_literal: true


    module Users
      # user session controller class
      class SessionsController < Devise::SessionsController
        skip_before_action :verify_signed_out_user, only: %i[destroy]

        def create
          user = User.find_by_email(auth_params[:email])
          if user&.valid_password?(auth_params[:password])
            render json: {message: 'success', response: user, status: 200}
          else
            invalid_login_attempt
          end
        end

        private

        
        def auth_params
          params.require(:session).permit(:email, :password)
        end

        def invalid_login_attempt
          render json: { message: 'Invalid email or password', status: 422}
        end
      end
    end

