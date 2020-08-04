# frozen_string_literal: true


    module Users
      # register user controller class
      class RegistrationsController < Devise::RegistrationsController
        before_action :ensure_params_exist, except: [:destroy]

        def create
          user = User.new(user_params)
          if user.save
            render json: {message: 'success', response: user, status: 200}
          else
            render json: {message: user.errors.full_messages, status: 422}
          end
        end

        private

        def user_params
          params.require(:user).permit(:email, :first_name, :last_name,  :password, :password_confirmation)
        end

        def ensure_params_exist
          return unless params[:user].blank?
          render json:{message: "Params Missing", status: 422 }
        end
      end
    end

